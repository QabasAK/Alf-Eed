# Rig Blender Studio's realistic base-mesh hand (CC0) with WebXR joint names and export a GLB.
# Joint centres come from the rings where the mesh's face sets meet (one face set per finger segment).
# Writes web/models/right-hand.glb. Needs Blender 4.2+ and the bundle from https://www.blender.org/download/demo-files/
# Usage: blender -b human_base_meshes_bundle.blend --factory-startup -P tool/rig_hand.py -- web/models/right-hand.glb
import bpy, bmesh, sys, mathutils
from collections import defaultdict
V = mathutils.Vector
OUT = sys.argv[sys.argv.index('--') + 1]

src = bpy.data.objects['Hand  - Realistic']
for o in list(bpy.data.objects):
    if o is not src: bpy.data.objects.remove(o)
bpy.context.view_layer.objects.active = src
src.select_set(True)
for m in list(src.modifiers): bpy.ops.object.modifier_apply(modifier=m.name)
bpy.ops.object.transform_apply(location=True, rotation=True, scale=True)
me = src.data
WRIST = V((1.405, 0.012, 0.335))  # where the forearm's cross-section stops narrowing, measured once by slicing the mesh
me.transform(mathutils.Matrix.Translation(-WRIST))  # the viewer expects the wrist at the origin

# ── joint centres from face-set boundaries ──
fs = me.attributes['.sculpt_face_set']
vsets = defaultdict(set)
for p in me.polygons:
    for v in p.vertices: vsets[v].add(fs.data[p.index].value)
def ring(a, b):
    ps = [me.vertices[v].co for v, s in vsets.items() if {a, b} <= s]
    assert len(ps) >= 12, (a, b, len(ps))
    return sum(ps, V()) / len(ps)
def lowest(k):
    return min((me.vertices[v].co for v, s in vsets.items() if k in s), key=lambda c: c.z).copy()
def tip(k, nail=10):  # tip of the pad, nudged inside the finger rather than on the skin
    ps = [me.vertices[v].co for v, s in vsets.items() if k in s or (nail in s and len(s) == 1)]
    lo = lowest(k)
    near = [p for p in ps if (p - lo).length < 0.008]
    return sum(near, V()) / len(near)

PALM, NAIL = 24, 10
# face sets per finger, base segment first, and the set holding the fingertip
SEGS = {'index': (19, 16, 3), 'middle': (18, 15, 4), 'ring': (17, 14, 5), 'pinky': (13, 12, 11)}
wrist = V((0, 0, 0))
J = {'wrist': wrist}
for f, (a, b, c) in SEGS.items():
    mcp, pip, dip = ring(a, PALM), ring(a, b), ring(b, c)
    mcp = mcp - (mcp - wrist).normalized() * 0.011  # the ring sits at the finger web; the knuckle joint is ~1 cm further into the hand
    J[f'{f}-finger-metacarpal'] = wrist.lerp(mcp, 0.15)
    J[f'{f}-finger-phalanx-proximal'] = mcp
    J[f'{f}-finger-phalanx-intermediate'] = pip
    J[f'{f}-finger-phalanx-distal'] = dip
    J[f'{f}-finger-tip'] = tip(c)
# thumb: 23 = thick base, 22 = middle, 21 = last segment; the metacarpal pivots deep in the palm near the wrist
J['thumb-metacarpal'] = wrist.lerp(ring(23, PALM), 0.4)
J['thumb-phalanx-proximal'] = ring(22, 23)
J['thumb-phalanx-distal'] = ring(21, 22)
J['thumb-tip'] = tip(21)
for k, v in J.items(): print('JOINT', k, tuple(round(x, 4) for x in v))

# ── trim the forearm to a short stub and close it ──
bm = bmesh.new(); bm.from_mesh(me)
cut = bmesh.ops.bisect_plane(bm, geom=bm.verts[:] + bm.edges[:] + bm.faces[:], plane_co=(0, 0, 0.05), plane_no=(0, 0, 1), clear_outer=True)
edges = [e for e in cut['geom_cut'] if isinstance(e, bmesh.types.BMEdge)]
bmesh.ops.holes_fill(bm, edges=edges)
bm.to_mesh(me); bm.free()

# ── smooth it once more for the sculpted look ──
mod = src.modifiers.new('sub', 'SUBSURF'); mod.levels = 1
bpy.ops.object.modifier_apply(modifier='sub')
bpy.ops.object.shade_smooth()
for a in [a.name for a in me.attributes if a.name.startswith('.sculpt') or a.name == 'sharp_face']:
    me.attributes.remove(me.attributes[a])

# ── armature: wrist → metacarpal → proximal → intermediate → distal → tip ──
arm = bpy.data.objects.new('Armature', bpy.data.armatures.new('Armature'))
bpy.context.scene.collection.objects.link(arm)
bpy.context.view_layer.objects.active = arm
bpy.ops.object.mode_set(mode='EDIT')
eb = arm.data.edit_bones
def add(name, head, tail, parent=None):
    b = eb.new(name); b.head, b.tail = head, tail
    if parent: b.parent = eb[parent]
    return b
add('wrist', wrist, wrist + V((0, 0, -0.02)))
chains = {f: [f'{f}-finger-metacarpal', f'{f}-finger-phalanx-proximal', f'{f}-finger-phalanx-intermediate', f'{f}-finger-phalanx-distal', f'{f}-finger-tip'] for f in SEGS}
chains['thumb'] = ['thumb-metacarpal', 'thumb-phalanx-proximal', 'thumb-phalanx-distal', 'thumb-tip']
for names in chains.values():
    parent = 'wrist'
    for i, n in enumerate(names):
        head = J[n]
        tail = J[names[i + 1]] if i + 1 < len(names) else head + (head - J[names[i - 1]]).normalized() * 0.008
        add(n, head, tail, parent); parent = n
bpy.ops.object.mode_set(mode='OBJECT')
tips = [names[-1] for names in chains.values()]
for n in tips: arm.data.bones[n].use_deform = False  # tips are markers only

# ── skin with heat weights ──
bpy.ops.object.select_all(action='DESELECT')
src.select_set(True); arm.select_set(True)
bpy.context.view_layer.objects.active = arm
bpy.ops.object.parent_set(type='ARMATURE_AUTO')
used = {x.group for v in me.vertices for x in v.groups if x.weight > 0.01}
print('groups', len(src.vertex_groups), 'empty', [g.name for g in src.vertex_groups if g.index not in used])
unweighted = sum(1 for v in me.vertices if not v.groups)
print('verts', len(me.vertices), 'unweighted', unweighted)
src.name = 'hand'

bpy.ops.object.select_all(action='SELECT')
bpy.ops.export_scene.gltf(filepath=OUT, export_format='GLB', use_selection=True, export_animations=False,
                          export_texcoords=False, export_materials='NONE', export_def_bones=False)
print('EXPORTED', OUT)

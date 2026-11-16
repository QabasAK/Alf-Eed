// Sends the 1000 Hands sign course from the Gmail account that owns the signup sheet.
//
// The Google Form adds sign-ups to the sheet. Once a day (and right after each sign-up), sendDue()
// copies new sign-ups to the Progress tab and sends each subscriber the next email once it is due:
// EMAILS[n].day days after they signed up. Progress keeps how many emails each person has had,
// so nobody gets the same email twice.
//
// Free Gmail accounts can send to 100 recipients a day from a script. Anyone not reached today
// gets their email tomorrow, and their later emails still follow their own schedule.

const DAILY_LIMIT = 90;  // leaves room for sendTestToMe() and replies
const PROGRESS = 'Progress';
const SENDER_NAME = '1000 Hands · الف ايد';
const CONTACT = 'liu.thousandhands@gmail.com';
const DAY_MS = 24 * 60 * 60 * 1000;

// Run once by hand after pasting: makes the signup form (if the sheet has none yet), the Progress
// tab and the two triggers. The form's link is in the log (View → Logs) and in the form's own tab.
function setup() {
  const ss = SpreadsheetApp.getActive();
  if (!ss.getSheets().some(s => s.getFormUrl())) {
    const form = FormApp.create('Learn JSL with 1000 Hands · تعلّم لغة الإشارة الأردنية')
      .setDescription('A free course by email: 3 Jordanian Sign Language signs a week, in 5 minutes, ' +
                      'with reviews spaced out so they stick. Signs from the Dictionary of Jordanian ' +
                      'Sign Language (SooSL).')
      .setEmailCollectionType(FormApp.EmailCollectionType.RESPONDER_INPUT)
      .setConfirmationMessage('You\'re in! Lesson 1 is on its way. Check your inbox (and spam, just in case).');
    form.setDestination(FormApp.DestinationType.SPREADSHEET, ss.getId());
    Logger.log('Signup form: ' + form.getPublishedUrl());
  }
  if (!ss.getSheetByName(PROGRESS)) {
    ss.insertSheet(PROGRESS).appendRow(['email', 'signed up', 'emails sent', 'token', 'unsubscribed']);
  }
  ScriptApp.getProjectTriggers().forEach(t => ScriptApp.deleteTrigger(t));
  ScriptApp.newTrigger('sendDue').timeBased().everyDays(1).atHour(9).create();
  ScriptApp.newTrigger('sendDue').forSpreadsheet(ss).onFormSubmit().create();
}

function sendDue() {
  const lock = LockService.getScriptLock();
  if (!lock.tryLock(30 * 1000)) return;  // another run is already sending
  try {
    const ss = SpreadsheetApp.getActive();
    const progress = ss.getSheetByName(PROGRESS);
    addNewSignups_(ss, progress);

    const rows = progress.getDataRange().getValues();
    const base = ScriptApp.getService().getUrl();
    let budget = Math.min(DAILY_LIMIT, MailApp.getRemainingDailyQuota());
    for (let r = 1; r < rows.length && budget > 0; r++) {
      const [email, signedUp, sent, token, unsubscribed] = rows[r];
      if (unsubscribed || sent >= EMAILS.length) continue;
      const days = Math.round((Date.now() - new Date(signedUp).getTime()) / DAY_MS);
      const next = EMAILS[sent];
      if (days < next.day) continue;
      const unsubscribe = base ? `${base}?u=${token}` : `mailto:${CONTACT}?subject=Unsubscribe`;
      MailApp.sendEmail({
        to: email,
        subject: next.subject,
        htmlBody: next.html.replace('{{UNSUBSCRIBE}}', unsubscribe),
        name: SENDER_NAME,
        replyTo: CONTACT,
      });
      progress.getRange(r + 1, 3).setValue(sent + 1);
      budget--;
    }
  } finally {
    lock.releaseLock();
  }
}

// Copies sign-ups from the form's response tab into Progress, once per email address.
function addNewSignups_(ss, progress) {
  const responses = ss.getSheets().find(s => s.getFormUrl());
  if (!responses) throw new Error('Link the signup Google Form to this spreadsheet first.');
  const [header, ...rows] = responses.getDataRange().getValues();
  const col = header.findIndex(h => /email/i.test(h));
  if (col < 0) throw new Error('The form needs an email question (turn on "Collect email addresses").');

  const known = new Set(progress.getDataRange().getValues().slice(1).map(r => String(r[0]).toLowerCase()));
  for (const row of rows) {
    const email = String(row[col]).trim().toLowerCase();
    if (!email.includes('@') || known.has(email)) continue;
    known.add(email);
    progress.appendRow([email, new Date(), 0, Utilities.getUuid(), '']);
  }
}

// The unsubscribe link in every email opens this (once deployed as a web app).
function doGet(e) {
  const token = e.parameter.u;
  const progress = SpreadsheetApp.getActive().getSheetByName(PROGRESS);
  const rows = progress.getDataRange().getValues();
  const r = token ? rows.findIndex(row => row[3] === token) : -1;
  if (r > 0) progress.getRange(r + 1, 5).setValue(new Date());
  return HtmlService.createHtmlOutput(
    '<div style="font-family:Arial,sans-serif;max-width:420px;margin:60px auto;text-align:center">' +
    (r > 0 ? '<h2>You\'re unsubscribed.</h2><p>You won\'t get any more lessons. Thanks for learning with us.</p>'
           : '<h2>Link not recognised.</h2><p>Reply to any lesson email and we\'ll take you off the list.</p>') +
    '</div>');
}

// Sends every email in the course to you, to check them before sharing the signup link.
function sendTestToMe() {
  const me = Session.getEffectiveUser().getEmail();
  EMAILS.forEach((e, i) => MailApp.sendEmail({
    to: me,
    subject: `[Test ${i + 1}/${EMAILS.length}, day ${e.day}] ${e.subject}`,
    htmlBody: e.html.replace('{{UNSUBSCRIBE}}', '#'),
    name: SENDER_NAME,
  }));
}

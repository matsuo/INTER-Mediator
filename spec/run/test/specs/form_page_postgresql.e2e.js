const FormPage = require('../pageobjects/form_postgresql.page');

const waiting = 500

let pageTitle
if (/*process.platform === 'darwin'*/ false) {
  pageTitle = "NTER-Mediator - サンプル - フォーム形式/PostgreSQL"
} else {
  pageTitle = "INTER-Mediator - Sample - Form Style/PostgreSQL"
}

describe('Form Page', () => {
  it('can open with the valid title', async () => {
    await FormPage.open()
    await expect(browser).toHaveTitle(pageTitle)
  });
  it('has the INTER-Mediator\'s navigation.', async () => {
    await expect(FormPage.navigator).toExist()
    await expect(FormPage.navigatorUpdateButton).toExist()
    await expect(FormPage.navigatorInfo).toExist()
    await expect(FormPage.navigatorMoveButtons).toBeElementsArrayOfSize(4)
    await expect(FormPage.navigatorMoveButtonFirst).toExist()
    await expect(FormPage.navigatorMoveButtonFirst).toHaveText('<<')
    await expect(FormPage.navigatorMoveButtonPrevious).toExist()
    await expect(FormPage.navigatorMoveButtonPrevious).toHaveText('<')
    await expect(FormPage.navigatorMoveButtonNext).toExist()
    await expect(FormPage.navigatorMoveButtonNext).toHaveText('>')
    await expect(FormPage.navigatorMoveButtonLast).toExist()
    await expect(FormPage.navigatorMoveButtonLast).toHaveText('>>')
    await expect(FormPage.navigatorDeleteButton).toExist()
    await expect(FormPage.navigatorInsertButton).toExist()
    await expect(FormPage.navigatorCopyButton).toExist()
  });
  it('can move current record with the navigation.', async () => {
    await expect(FormPage.fieldPersonId).toExist()
    await expect(FormPage.fieldPersonId).toHaveText("1")
    await FormPage.navigatorMoveButtonNext.waitForClickable()
    await FormPage.navigatorMoveButtonNext.click()
    await browser.pause(waiting)
    await expect(FormPage.fieldPersonId).toExist()
    await expect(FormPage.fieldPersonId).toHaveText("2")
    await FormPage.navigatorMoveButtonNext.waitForClickable()
    await FormPage.navigatorMoveButtonNext.click()
    await browser.pause(waiting)
    await expect(FormPage.fieldPersonId).toExist()
    await expect(FormPage.fieldPersonId).toHaveText("3")
    await FormPage.navigatorMoveButtonPrevious.waitForClickable()
    await FormPage.navigatorMoveButtonPrevious.click()
    await browser.pause(waiting)
    await expect(FormPage.fieldPersonId).toExist()
    await expect(FormPage.fieldPersonId).toHaveText("2")
    await FormPage.navigatorMoveButtonLast.waitForClickable()
    await FormPage.navigatorMoveButtonLast.click()
    await browser.pause(waiting)
    await expect(FormPage.fieldPersonId).toExist()
    await expect(FormPage.fieldPersonId).toHaveText("3")
    await FormPage.navigatorMoveButtonFirst.waitForClickable()
    await FormPage.navigatorMoveButtonFirst.click()
    await browser.pause(waiting)
    await expect(FormPage.fieldPersonId).toExist()
    await expect(FormPage.fieldPersonId).toHaveText("1")
  });
  it('can retrieve the first record from database.', async () => {
    await FormPage.navigatorMoveButtonFirst.waitForClickable()
    await FormPage.navigatorMoveButtonFirst.click()
    await browser.pause(waiting)

    await expect(FormPage.fieldPersonId).toHaveText("1")
    await expect(FormPage.fieldPersonCategory).toHaveValue("")
    await expect(FormPage.fieldPersonCategory).toHaveText("Family\nClassMate\nCollegue")
    await expect(FormPage.fieldPersonCheck).not.toBeSelected()
    await expect(FormPage.fieldPersonName).toHaveValue("Masayuki Nii")
    await expect(FormPage.fieldPersonMail).toHaveValue("msyk@msyk.net")
    await expect(FormPage.fieldPersonLocations[0]).not.toBeSelected()
    await expect(FormPage.fieldPersonLocations[1]).not.toBeSelected()
    await expect(FormPage.fieldPersonLocations[2]).not.toBeSelected()
    await expect(FormPage.fieldPersonLocations[3]).not.toBeSelected()
    await expect(FormPage.fieldPersonMemo).toHaveValue("")
  });
  it('can retrieve the second record from database.', async () => {
    await FormPage.navigatorMoveButtonNext.click()
    await browser.pause(waiting)

    await expect(FormPage.fieldPersonId).toHaveText("2")
    await expect(FormPage.fieldPersonCategory).toHaveValue("")
    await expect(FormPage.fieldPersonCategory).toHaveText("Family\nClassMate\nCollegue")
    await expect(FormPage.fieldPersonCheck).not.toBeSelected()
    await expect(FormPage.fieldPersonName).toHaveValue("Someone")
    await expect(FormPage.fieldPersonMail).toHaveValue("msyk@msyk.net")
    await expect(FormPage.fieldPersonLocations[0]).not.toBeSelected()
    await expect(FormPage.fieldPersonLocations[1]).not.toBeSelected()
    await expect(FormPage.fieldPersonLocations[2]).not.toBeSelected()
    await expect(FormPage.fieldPersonLocations[3]).not.toBeSelected()
    await expect(FormPage.fieldPersonMemo).toHaveValue("")
  });
  it('can retrieve the third record from database.', async () => {
    await FormPage.navigatorMoveButtonNext.waitForClickable()
    await FormPage.navigatorMoveButtonNext.click()
    await browser.pause(waiting)

    await expect(FormPage.fieldPersonId).toHaveText("3")
    await expect(FormPage.fieldPersonCategory).toHaveValue("")
    await expect(FormPage.fieldPersonCategory).toHaveText("Family\nClassMate\nCollegue")
    await expect(FormPage.fieldPersonCheck).not.toBeSelected()
    await expect(FormPage.fieldPersonName).toHaveValue("Anyone")
    await expect(FormPage.fieldPersonMail).toHaveValue("msyk@msyk.net")
    await expect(FormPage.fieldPersonLocations[0]).not.toBeSelected()
    await expect(FormPage.fieldPersonLocations[1]).not.toBeSelected()
    await expect(FormPage.fieldPersonLocations[2]).not.toBeSelected()
    await expect(FormPage.fieldPersonLocations[3]).not.toBeSelected()
    await expect(FormPage.fieldPersonMemo).toHaveValue("")
  });
  it('can edit the first record.', async () => {
    await FormPage.navigatorUpdateButton.waitForClickable();
    await FormPage.navigatorUpdateButton.click();
    await browser.pause(waiting)

    await expect(FormPage.fieldPersonId).toHaveText("1")
    await FormPage.fieldPersonCategory.waitForClickable()
    await FormPage.fieldPersonCategory.selectByVisibleText('Family')
    await FormPage.fieldPersonCheck.waitForClickable()
    await FormPage.fieldPersonCheck.click()
    await FormPage.fieldPersonName.setValue("edit1")
    await FormPage.fieldPersonLocations[0].waitForClickable()
    await FormPage.fieldPersonLocations[0].click()
    await FormPage.fieldPersonMemo.setValue("first\nsecond\nthird")
  });
  it('can store the edited data on the first record.', async () => {
    await FormPage.navigatorUpdateButton.waitForClickable();
    await FormPage.navigatorUpdateButton.click();
    await browser.pause(waiting)

    await expect(FormPage.fieldPersonId).toHaveText("1")
    await expect(FormPage.fieldPersonCategory).toHaveValue("101")
    await expect(FormPage.fieldPersonCategory).toHaveText("Family\nClassMate\nCollegue")
    await expect(FormPage.fieldPersonCheck).toBeSelected()
    await expect(FormPage.fieldPersonName).toHaveValue("edit1")
    await expect(FormPage.fieldPersonMail).toHaveValue("msyk@msyk.net")
    await expect(FormPage.fieldPersonLocations[0]).toBeSelected()
    await expect(FormPage.fieldPersonLocations[1]).not.toBeSelected()
    await expect(FormPage.fieldPersonLocations[2]).not.toBeSelected()
    await expect(FormPage.fieldPersonLocations[3]).not.toBeSelected()
    await expect(FormPage.fieldPersonMemo).toHaveValue("first\nsecond\nthird")
  });
  it('detail area expanded with multi-record', async () => {
    await FormPage.navigatorUpdateButton.waitForClickable();
    await FormPage.navigatorUpdateButton.click();
    await browser.pause(waiting)

    await expect(FormPage.contactTable).toExist() // check the detailed Contact table
    const rows = FormPage.rowContact
    await expect(rows[0]).toExist() // There has three lines
    await expect(rows[1]).toExist()
    await expect(rows[2]).toExist()
    await expect(rows[3]).not.toExist()

    await expect(FormPage.rowContactDateTime[0]).toHaveValue('2009-12-01T15:23')
    await expect(FormPage.rowContactSummary[0]).toHaveValue('Telephone')
    await expect(FormPage.rowContactImportant[0]).not.toBeSelected()
    await expect(FormPage.rowContactWay[0]).toHaveValue('4')
    await expect(FormPage.rowContactKind[0]).toHaveValue('4')
    await expect(FormPage.rowContactDescription[0]).toHaveValue('')

    await expect(FormPage.rowContactDateTime[1]).toHaveValue('2009-12-02T15:23')
    await expect(FormPage.rowContactSummary[1]).toHaveValue('Meeting')
    await expect(FormPage.rowContactImportant[1]).toBeSelected()
    await expect(FormPage.rowContactWay[1]).toHaveValue('4')
    await expect(FormPage.rowContactKind[1]).toHaveValue('7')
    await expect(FormPage.rowContactDescription[1]).toHaveValue('')

    await expect(FormPage.rowContactDateTime[2]).toHaveValue('2009-12-03T15:23')
    await expect(FormPage.rowContactSummary[2]).toHaveValue('Mail')
    await expect(FormPage.rowContactImportant[2]).not.toBeSelected()
    await expect(FormPage.rowContactWay[2]).toHaveValue('5')
    await expect(FormPage.rowContactKind[2]).toHaveValue('8')
    await expect(FormPage.rowContactDescription[2]).toHaveValue('')
  });
  it('works two popup menus that are depending with relationship.', async () => {
    await FormPage.navigatorMoveButtonFirst.waitForClickable();
    await FormPage.navigatorMoveButtonFirst.click() // Move to first record
    await FormPage.navigatorUpdateButton.waitForClickable();
    await FormPage.navigatorUpdateButton.click();
    await FormPage.rowContact[0].waitForExist()
    await expect(FormPage.rowContact[0]).toExist()
    await expect(FormPage.rowContactWay[0]).toHaveText("Direct\nIndirect\nOthers")
    await expect(FormPage.rowContactKind[0]).toHaveText("Talk\nMeet\nMeeting")

    await FormPage.rowContactWay[0].selectByIndex(1)
    await expect(FormPage.rowContactWay[0]).toHaveValue('5')
    await expect(FormPage.rowContactKind[0]).toHaveText("Calling\nMail\nEmail\nSee on Chat\nTwitter")
    await expect(FormPage.rowContactKind[0]).toHaveValue('')
    await FormPage.rowContactKind[0].selectByIndex(1)
    await expect(FormPage.rowContactKind[0]).toHaveValue('8')

    await FormPage.rowContactWay[0].selectByIndex(2)
    await expect(FormPage.rowContactWay[0]).toHaveValue('6')
    await expect(FormPage.rowContactKind[0]).toHaveText("See on Web\nTwitter\nConference")
    await expect(FormPage.rowContactKind[0]).toHaveValue('')
    await FormPage.rowContactKind[0].selectByIndex(1)
    await expect(FormPage.rowContactKind[0]).toHaveValue('12')

    await expect(FormPage.rowContact[1]).toExist()
    await FormPage.rowContactWay[1].selectByIndex(2)
    await expect(FormPage.rowContactWay[1]).toHaveValue('6')
    await expect(FormPage.rowContactKind[1]).toHaveText("See on Web\nTwitter\nConference")
    await expect(FormPage.rowContactKind[1]).toHaveValue('')
    await FormPage.rowContactKind[1].selectByIndex(2)
    await expect(FormPage.rowContactKind[1]).toHaveValue('13')
  });
  it('can insert a row into detail area.', async () => {
    await FormPage.navigatorUpdateButton.waitForClickable();
    await FormPage.navigatorUpdateButton.click();
    await FormPage.contactTableInsertButton.waitForClickable()
    await expect(FormPage.contactTableInsertButton).toExist()
    await FormPage.contactTableInsertButton.click()
    await browser.acceptAlert()
    await browser.pause(waiting * 2)
    const rows = FormPage.rowContact
    await rows[0].waitForExist()
    await rows[1].waitForExist()
    await rows[2].waitForExist()
    await rows[3].waitForExist()
    await expect(rows[0]).toExist() // There has three lines
    await expect(rows[1]).toExist()
    await expect(rows[2]).toExist()
    await expect(rows[3]).toExist()
    await expect(rows[4]).not.toExist()
    await expect(FormPage.rowContactSummary[3]).toHaveValue('')
  })
  it('can delete a row in detail area.', async () => {
    // await FormPage.open()
    // await browser.pause(waiting)
    await FormPage.navigatorUpdateButton.waitForClickable()
    await FormPage.navigatorUpdateButton.click();
    await FormPage.rowContactDeleteButton[1].waitForClickable()
    await FormPage.rowContactDeleteButton[1].click()
    await browser.acceptAlert()
    await browser.pause(waiting * 2)

    const rows = FormPage.rowContact
    await rows[0].waitForExist()
    await rows[1].waitForExist()
    await rows[2].waitForExist()
    await expect(rows[0]).toExist() // There has three lines
    await expect(rows[1]).toExist()
    await expect(rows[2]).toExist()
    await expect(rows[3]).not.toExist()
    await expect(rows[4]).not.toExist()
  })
  it('can copy a row in detail area.', async () => {
    // await FormPage.open()
    // await browser.pause(waiting)
    await FormPage.navigatorUpdateButton.click();
    await FormPage.contactTableInsertButton.waitForClickable()

    const value = await FormPage.rowContactSummary[1].getValue()
    await expect(FormPage.contactTableInsertButton).toExist()
    await FormPage.rowContactDeleteButton[1].waitForClickable()
    await FormPage.rowContactCopyButton[1].click()
    //await browser.acceptAlert()
    await browser.pause(waiting * 2)

    const rows = FormPage.rowContact
    await rows[0].waitForExist()
    await rows[1].waitForExist()
    await rows[2].waitForExist()
    await rows[3].waitForExist()
    await expect(rows[0]).toExist() // There has three lines
    await expect(rows[1]).toExist()
    await expect(rows[2]).toExist()
    await expect(rows[3]).toExist()
    await expect(rows[4]).not.toExist()
    await browser.pause(waiting * 2)
    await expect(FormPage.rowContactSummary[3]).toHaveValue(value)
  })

});


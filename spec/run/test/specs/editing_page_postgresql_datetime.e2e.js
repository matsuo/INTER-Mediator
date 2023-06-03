const EditingPage = require('../pageobjects/editing_page_postgresql.page');

const waiting = 1000
// const initDateTime = "2000-12-31 15:00:00" // For Asia/Tokyo server
// const initTime = "15:00:00" // For Asia/Tokyo server
const initDateTime = "2001-01-01 00:00:00" // For UCT server
const initTime = "00:00:00" // For UCT server

describe('Editing Page Date/Time Fields', () => {
  it('can open with the valid title.', async () => {
    await EditingPage.open()
    await expect(browser).toHaveTitle("INTER-Mediator - Sample - Editing/PostgreSQL"/*'INTER-Mediator - サンプル - フォーム形式/MySQL'*/)
  })
  it('has the INTER-Mediator\'s navigation.', async () => {
    await expect(EditingPage.navigator).toExist()
    await expect(EditingPage.navigatorUpdateButton).toExist()
    await expect(EditingPage.navigatorInfo).toExist()
    await expect(EditingPage.navigatorMoveButtons).toBeElementsArrayOfSize(4)
    await expect(EditingPage.navigatorMoveButtonFirst).toExist()
    await expect(EditingPage.navigatorMoveButtonFirst).toHaveText('<<')
    await expect(EditingPage.navigatorMoveButtonPrevious).toExist()
    await expect(EditingPage.navigatorMoveButtonPrevious).toHaveText('<')
    await expect(EditingPage.navigatorMoveButtonNext).toExist()
    await expect(EditingPage.navigatorMoveButtonNext).toHaveText('>')
    await expect(EditingPage.navigatorMoveButtonLast).toExist()
    await expect(EditingPage.navigatorMoveButtonLast).toHaveText('>>')
    await expect(EditingPage.navigatorInsertButton).toExist()
    await EditingPage.navigatorInsertButton.click()
    await EditingPage.navigatorInsertButton.waitForClickable()
    await EditingPage.navigatorUpdateButton.click()
    await browser.pause(waiting)
    await EditingPage.reopen()
  })
  it('can edit the text field of datetime field which is NOT NULL.', async () => {
    await expect(EditingPage.fieldDt1Textfield).toExist()
    await expect(EditingPage.fieldDt1Textfield).toHaveValue(initDateTime) // Checking initial value
    const value = new Date().toISOString().substring(0, 19).replace("T", " ")
    await EditingPage.fieldDt1Textfield.setValue(value) // Set a value to the field
    await EditingPage.navigatorUpdateButton.click()
    await browser.pause(waiting)
    await expect(EditingPage.fieldDt1Textfield).toHaveValue(String(value))
    // This field can't clear
  })
  it('can edit the text field of nullable datetime field.', async () => {
    await expect(EditingPage.fieldDt2Textfield).toExist()
    await expect(EditingPage.fieldDt2Textfield).toHaveValue("") // Checking initial value
    const value = new Date().toISOString().substring(0, 19).replace("T", " ")
    await EditingPage.fieldDt2Textfield.setValue(value) // Set a value to the field
    await EditingPage.navigatorUpdateButton.click()
    await browser.pause(waiting)
    await expect(EditingPage.fieldDt2Textfield).toHaveValue(String(value))
    await EditingPage.fieldDt2Textfield.setValue("") // clear the field
    await EditingPage.navigatorUpdateButton.click()
    await browser.pause(waiting)
    await expect(EditingPage.fieldDt2Textfield).toHaveValue("")
    // This field can't clear
  })
  it('can edit the text field of date field which is NOT NULL.', async () => {
    await expect(EditingPage.fieldDate1Textfield).toExist()
    await expect(EditingPage.fieldDate1Textfield).toHaveValue("2001-01-01") // Checking initial value
    const value = new Date().toISOString().substring(0, 10)
    // await EditingPage.fieldDate1Textfield.clearValue()
    // await browser.pause(waiting)
    await EditingPage.fieldDate1Textfield.setValue(value) // Set a value to the field
    await EditingPage.navigatorUpdateButton.click()
    await browser.pause(waiting)
    await expect(EditingPage.fieldDate1Textfield).toHaveValue(String(value))
    // This field can't clear
  })
  it('can edit the text field of nullable date field.', async () => {
    await expect(EditingPage.fieldDate2Textfield).toExist()
    await expect(EditingPage.fieldDate2Textfield).toHaveValue("") // Checking initial value
    const value = new Date().toISOString().substring(0, 10)
    await EditingPage.fieldDate2Textfield.setValue(value) // Set a value to the field
    await EditingPage.navigatorUpdateButton.click()
    await browser.pause(waiting)
    await expect(EditingPage.fieldDate2Textfield).toHaveValue(String(value))
    await EditingPage.fieldDate2Textfield.setValue("") // Clear the field
    await EditingPage.navigatorUpdateButton.click()
    await browser.pause(waiting)
    await expect(EditingPage.fieldDate2Textfield).toHaveValue("")

  })
  it('can edit the text field of time field which is NOT NULL.', async () => {
    await expect(EditingPage.fieldTime1Textfield).toExist()
    await expect(EditingPage.fieldTime1Textfield).toHaveValue(initTime) // Checking initial value
    const value = new Date().toISOString().substring(11, 19)
    // await EditingPage.fieldTime1Textfield.clearValue()
    // await browser.pause(waiting)
    await EditingPage.fieldTime1Textfield.setValue(value) // Set a value to the field
    await EditingPage.navigatorUpdateButton.click()
    await browser.pause(waiting)
    await expect(EditingPage.fieldTime1Textfield).toHaveValue(String(value))
    // This field can't clear
  })
  it('can edit the text field of nullable time field.', async () => {
    await expect(EditingPage.fieldTime2Textfield).toExist()
    await expect(EditingPage.fieldTime2Textfield).toHaveValue("") // Checking initial value
    const value = new Date().toISOString().substring(11, 19)
    await EditingPage.fieldTime2Textfield.setValue(value) // Set a value to the field
    await EditingPage.navigatorUpdateButton.click()
    await browser.pause(waiting)
    await expect(EditingPage.fieldTime2Textfield).toHaveValue(String(value))
    await EditingPage.fieldTime2Textfield.setValue("") // Clear the field
    await EditingPage.navigatorUpdateButton.click()
    await browser.pause(waiting)
    await expect(EditingPage.fieldTime2Textfield).toHaveValue("")
  })

  // The ts1, ts2 fields are timestamp type and it's same as dt1, dt2.

})



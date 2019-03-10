const puppeteer = require('puppeteer');

const USERNAME_SELECTOR = '#identifierId';
const username ='jaskon139@huayuworld.org';
const loginSelector = '#identifierNext > content > span';

async function run() {
  const browser = await puppeteer.launch({
			args: ['--no-sandbox', '--incognito'] ,
			headless: true
		});

  const page = await browser.newPage();
  console.log(await page.evaluate(() => navigator.userAgent));
  await page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36')
  await page.goto('https://colab.research.google.com/drive/12MM8H5MlyVe0JwIojxZRdC8x0pBvJpdi', { waitUntil: "networkidle2" });
	// hacky defensive move but I don't know a better way:
	// wait a bit so that the browser finishes executing JavaScript
  await page.waitFor(1 * 1000);
	
  await page.waitForSelector('input[type="email"]')
  await page.screenshot({path: 'screenshot\\github0.png'});
  await page.type('input[type="email"]', username)
  await page.click('#identifierNext')
  
  await page.waitFor(1 * 1000); 
    
  await page.waitForSelector('input[type="password"]', { visible: true })
  await page.type('input[type="password"]',"hellohello") 
  await page.screenshot({path: 'screenshot\\github1.png'});
    
  await page.waitForSelector('#passwordNext', { visible: true })
  await page.click('#passwordNext')
  await page.screenshot({path: 'screenshot\\github3.png'});
  
await page.waitFor(30 * 1000);
  await page.screenshot({path: 'screenshot\\github4.png'});
  await page.waitFor(3 * 1000);
  
  await page.keyboard.down('Control');
  await page.keyboard.press('F9');
  await page.keyboard.up('Control');
  console.log('Pressed Ctrl-F9');

  await page.waitFor(30 *1000);

  await page.screenshot({path: 'screenshot\\github5.png'});

  var t = 5;

  setInterval(function () {
        t=t+1;
        page.screenshot( { path: 'screenshot\\github'+ t + '.png'});
  }, 300*1500);
  //login colab
  //await page.goto('https://colab.research.google.com/drive/1WwKxek-2R3txpjPi-Ly2HrxLxIE06Fom');
//
//  await page.waitFor(60000 * 1000);
//  browser.close();
}

run();

const puppeteer = require('puppeteer');

const USERNAME_SELECTOR = '#identifierId';
const username ='junjieh7@gmail.com';
const loginSelector = '#identifierNext > content > span';

async function run() {
  const browser = await puppeteer.launch({
			args: ['--no-sandbox', '--incognito'] ,
			headless: true
		});

  const page = await browser.newPage();
  console.log(await page.evaluate(() => navigator.userAgent));
  await page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36')
  await page.goto('https://colab.research.google.com/drive/10qHHyXFCpT9NdXw9vxk0Q-GOaQFWUy0K', { waitUntil: "networkidle2" });
	// hacky defensive move but I don't know a better way:
	// wait a bit so that the browser finishes executing JavaScript
  await page.waitFor(1 * 1000);

  await page.screenshot({path: 'screenshot\\github0.png'});
  await page.waitForSelector('#identifierId');
  await page.screenshot({path: 'screenshot\\github1.png'});
  await page.type('#identifierId', username, { delay: 5 });
  await page.click('#identifierNext');

  await page.waitFor(1 * 1000);
  await page.screenshot({path: 'screenshot\\github2.png'});

  //login the google
  await page.waitForSelector('#frmLogin_UserName');
  await page.type('#frmLogin_UserName', 'cubbage_ronny', { delay: 5 } );

  await page.waitFor(6 * 1000);
  await page.waitForSelector('#frmLogin_Password');
  await page.click('#frmLogin_Password');
  await page.type('#frmLogin_Password', 'Hellohello2000', { delay: 5 } );  

  await page.waitFor(1 * 1000);
  await page.click('#btnLogin');
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

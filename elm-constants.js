const fs = require('fs');
const path = require('path');
require('dotenv').config();

const outputFilePath = path.join(__dirname, './public/constants.js');

const constants = {
	NASA_API_KEY: process.env.NASA_API_KEY,
	// Add other environment variables here if needed
};

const constantsScript = `window.constants = ${JSON.stringify(constants, null, 2)};`;

fs.writeFile(outputFilePath, constantsScript, 'utf8', (err) => {
	if (err) {
		console.error('Error writing the output file:', err);
		return;
	}

	console.log('constants.js has been created in the public folder with the environment variables.');
});

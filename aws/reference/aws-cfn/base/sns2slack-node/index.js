'use strict';

var https = require('https');


let SLACK_WEB_HOOK_URL = process.env.WEB_HOOK_PATH;
let channelPrefix = '#' + process.env.CHANNEL;

//lambda-local -l index.js -h handler -e event.json -t 5 -E '{"WEB_HOOK_PATH":"/services/T0675A0CX/B7B91T4CT/obbhGr89zKjgPBKJuDRhXA3O","CHANNEL":"noah.liu"}'
exports.handler = function(event, context) {
  let text = "";
  let preText = "";
  let message = "";
  let date = null;
  if (typeof event === "undefined" || typeof event.Records === "undefined" || typeof event.Records[0].Sns === "undefined"){
    message = JSON.stringify(context);
  } else {
    preText = event.Records[0].Sns.Subject;
    message = event.Records[0].Sns.Message;
    if (event.Records[0].Sns.Timestamp)
      date = new Date(event.Records[0].Sns.Timestamp).getTime()/1000;
  }

  // format data.
  let color = getColor(message);
  let channel = channelPrefix;
  switch (color){
    case 'danger':
      channel += 'error';
    break;
    case 'warning':
      channel += 'warn';
    break;
    default:
      channel += 'info';
  }
  try{  // if json , formatting with 2 spaces.
    message = JSON.stringify(JSON.parse(message),null,2);
  }catch(error){}


  // http body
  let postData = {
    "username": "AWS SNS",
    "channel": channel,
    "text": text
  };
  postData.attachments = [
    {
      "color": color,
      "pretext": preText,
      "text": message,
      "ts": date
    }
  ];

  // http header (options)
  let options = {
    method: 'POST',
    hostname: 'hooks.slack.com',
    port: 443,
    path: SLACK_WEB_HOOK_URL
  };

  let req = https.request(options, (res) => {
    res.setEncoding('utf-8');
    res.on('data', (data) => {
      console.log('http-request-body=',data);
      context.succeed();
    });
  });
  req.on('error', (e) => {
    console.log('problem with request:' , e.message);
  });
  req.write(JSON.stringify(postData));
  req.end();

};


function getColor(message){
  let color = "good";
  message = JSON.stringify(message).toLowerCase();

  let dangerMessages = [
    "exception" ,"error" ,"aborted" ,"failed" ,"not authorized" ,"unsuccessful" ,"do not have permission"
  ];
  let warningMessages = [
    "warning" , "pending" ,"removed" ,"rollback" ,"delete" ,"adding instance"
  ];

  for(let item in dangerMessages) {
    if (message.indexOf(dangerMessages[item])>=0){
      color = "danger";
      break;
    }
  }
  if (color === "good") {
    for(let item in warningMessages) {
      if (message.indexOf(warningMessages[item])>=0){
        color = "warning";
        break;
      }
    }
  }
  return color;
}

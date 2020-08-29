// See https://github.com/dialogflow/dialogflow-fulfillment-nodejs
// for Dialogflow fulfillment library docs, samples, and to report issues
'use strict';
const axios = require('axios');
const functions = require('firebase-functions');
const {WebhookClient} = require('dialogflow-fulfillment');
const {Card, Suggestion} = require('dialogflow-fulfillment');
const {dialogflow,BasicCard,Button,Image} = require('actions-on-google');
 
process.env.DEBUG = 'dialogflow:debug'; // enables lib debugging statements
 
exports.dialogflowFirebaseFulfillment = functions.https.onRequest((request, response) => {
  const agent = new WebhookClient({ request, response });
  console.log('Dialogflow Request headers: ' + JSON.stringify(request.headers));
  console.log('Dialogflow Request body: ' + JSON.stringify(request.body));
 
  function welcome(agent) {
    agent.add(`Hola!! My name is Panda and I am your Personal Assistant Counselling Bot. How can I ease your search? Only ask Career related questions!!`);
    agent.add(new Card({
      title:"Your Counseller 🤓",
      imageUrl:"https://us.123rf.com/450wm/bsd555/bsd5551809/bsd555180900169/110462312-stock-vector-machine-learning-chalk-icon-artificial-intelligence-teacher-bot-graduated-robot-chatbot-bot-in-gradu.jpg?ver=6",
      text:"We provide Career guidance and help you enhance your Aptitude Skills."
    })
    );
    agent.add('You can Explore our Application by typing Explore App');
    agent.add(new Suggestion("Have a question"));
    agent.add(new Suggestion("Job Search"));
    agent.add(new Suggestion("Find School"));
    agent.add(new Suggestion("Find Colleges"));
    
  }     
      
              
  function fallback(agent) {
    agent.add(`I didn't understand`);
    agent.add(`I'm sorry, can you try again?`);
  }
  function GoogleFunctionHandler(agent){
    const query=agent.parameters.any;
    agent.add("Google Says: ");
    return axios.get(`https://www.googleapis.com/customsearch/v1?key=*******************&cx=*************&q=${query}`)
    .then((result) => {
      //console.log(result.data);
      for (var i = 0; i < 3; i++) {
        var item = result.data.items[i];
        //console.log(item.snippet,item.link);
        //agent.add(item.snippet);
        agent.add("Follow the below links:  ");
        agent.add(item.link);
      }
     
      
    });
  
  }
  
  function jobHandler(agent){
    const query=agent.parameters.any;
    //agent.add("Google Says: ");
    return axios.get(`https://www.googleapis.com/customsearch/v1?key=*****************&cx=******************&q=${query}`)
    .then((result) => {
      //console.log(result.data);
      for (var i = 0; i < 3; i++) {
        var item = result.data.items[i];
        //console.log(item.snippet,item.link);
        //agent.add(item.snippet);
        agent.add("Here are the links:  ");
        agent.add(item.link);
      }
     
      
    });
  
  }
  
  function ExploreHandler(agent){
    agent.add("CAREER SUCCOUR 🧐 provides Career guidance to School Students, College Students and Dropouts");
    agent.add("You can choose your category and accordingly a list of Psychiometric Test will appear on your dashboard 📋. Appear for the test and receive Career suggestions.");
    agent.add("We provide: ");
    agent.add("1.Career Articles");
    agent.add("2.Career Talks");
    agent.add("3.Career Counselling Bot");
              
              
  }
  
  
  
  // Run the proper function handler based on the matched Dialogflow intent name
  let intentMap = new Map();
  intentMap.set('Default Welcome Intent', welcome);
  intentMap.set('Default Fallback Intent', fallback);
  intentMap.set('Google', GoogleFunctionHandler);
  intentMap.set('Explore_app', ExploreHandler);
  intentMap.set('job_google',jobHandler);
  agent.handleRequest(intentMap);
});

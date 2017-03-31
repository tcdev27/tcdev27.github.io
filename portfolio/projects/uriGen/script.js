
function genURI() {
    var check = document.getElementById('output');
    if(!check) {
      // Select Each Field Based on their Names and get the Values <--- This will require the page to have the correct names for each field.
      var programmeID = +document.querySelector("input[name='programme_id']").value; // Added the '+' to start to ensure that it does return 'number' if it is one
      var channelID = +document.querySelector("input[name='channel_id']").value;
      var redirectTo = document.querySelector("input[name='redirect_to']").value;

      // Validation
      result = validate(programmeID, channelID, redirectTo);
      if (result == true) {
        outputURI(programmeID, channelID, redirectTo);
      } else {
        alert('Error: \n' + result.join('\n'));
      }
    } else {
      document.getElementById('output').remove();
      genURI();
    }


}

function outputURI(programmeID, channelID, redirectTo) {
  var uri = "http://localhost:3000/ww/form_builder/forms/14/completions/new?programme_id=" + programmeID + "&channel_id=" + channelID + "&redirect_to=" + redirectTo;

  //document.getElementById("output").innerHTML = uri;

  var outputStyle = 'padding: 2.5%; color: #fff; background-color: #474e56; border-radius: 5px; font-size: 16pt;';
  var btnStyle = 'color: #474e56;'
  var copyBtn = '<button type="button" onclick="copyUri()" style="' + btnStyle + '">Copy to Clipboard</button>'
  var resetBtn = '<button type="button" onclick="resetGen()" style="' + btnStyle + '">Reset</button>'

  document.body.innerHTML +=
  '<div width="100%" style="'+ outputStyle +'" id="output">' + '<h1 style="font-size: 125%">URI: </h1>' + '<p id="uri">' + uri + '</p>' + copyBtn + '<textarea id="hiddenUri" style="position: absolute; top: -100%">' + uri +'</textarea>' + resetBtn + '</div>';
}

function validate(programmeID, channelID, redirectTo) {
  var messages = [];
  //Check for an Input for Each Field
  if (programmeID) {

  } else {
    messages.push('Please Enter a Programme ID.');
  }
  if (channelID) {

  } else {
    messages.push('Please Enter a Channel ID.');
  }
  if (redirectTo) {

  } else {
    messages.push('Please Enter a Redirect Path.');
  }

  //Validate the Data types

  //Get the data type for each field
  var type1 = typeof programmeID;
  var type2 = typeof channelID;
  var type3 = typeof redirectTo;



  //Check the data types
  if (type1 == "number") {
  } else {
      messages.push('Invalid Programme ID: It Must be a Number.');
  }
  if(type2 == "number") {

  }else {
    messages.push('Invalid Channel ID: It Must be a Number');
  }
  if (programmeID > 0) {

  } else {
    messages.push('Invalid Programme ID: It cannot be Negative.');
  }
  if (channelID > 0) {

  } else {
    messages.push('Invalid Channel ID: It cannot be Negative.');
  }




  // if any errors, return them instead
  if (messages.length> 0) {
    return(messages);
  } else {
    return true;
  }
}

function copyUri() {
  var output = document.getElementById('hiddenUri');
  output.select();
  document.execCommand('copy');
}

function resetGen() {
//  location.reload();
  document.getElementById('output').remove();
}

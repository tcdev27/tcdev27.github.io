
function genURI() {

    // Select Each Field Based on their Names and get the Values <--- This will require the page to have the correct names for each field.
    var programmeID = document.querySelector("input[name='programme_id']").value;
    var channelID = document.querySelector("input[name='channel_id']").value;
    var redirectTo = document.querySelector("input[name='redirect_to']").value;
    console.log(programmeID + channelID + redirectTo);

    console.log(document.getElementById("uriForm").checkValidity());

    // Validation
    //Get the data type for each field
    var type1 = typeof programmeID;
    var type2 = typeof channelID;
    var type3 = typeof redirectTo;
    console.log(type1 + type2 + type3);
    //Check the data types
    if (type1 == "integer" && type2 == "integer" && type3 == "string") {
        console.log('Valid!');
    } else {
        console.log('Invalid!');
    }


    var uri = "http://localhost:3000/ww/form_builder/forms/14/completions/new?programme_id=" + programmeID + "&channel_id=" + channelID + "&redirect_to=" + redirectTo;

    var output = document.getElementById("output").innerHTML = uri;programmeID
}

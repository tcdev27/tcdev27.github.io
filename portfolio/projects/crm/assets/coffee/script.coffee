$ ->

  #Move Scripts Down to bottom of body
  scripts = $('script')
  $('body').append(scripts)
  #$('link[href="assets/css/old-application.css"]').remove();

  #Add Meta Tag for Viewport
  #This Causes Issues, but sets off in the right way of using the bootstrap mobile nav
  $('head').append('<meta name="viewport" content="width=device-width, initial-scale=1">');

  table = $ "table"
  table.attr "role", "grid"
  table.attr "aria-colcount", "7"

  tableHead = $ "thead"
  tableHead.attr "role", "rowgroup"

  tableBody = $ "tbody"
  tableBody.attr "role", "rowgroup"

  rows = $ "tr"
  rows.attr "role", "row"

  headCells = $ "th"
  headCells.attr "role", "columnheader"

  bodyCells = $ "td"
  bodyCells.attr "role", "gridcell"

  x = 1
  $('th').each ->
    $(@).attr "aria-colindex", x
    x = x + 1

  y = 1
  $('td').each ->
    if y > 7
      y = 1
    $(@).attr "aria-colindex", y
    y = y + 1
  #Add 3 New Columns for the Table Links
  #$("thead>tr").append $('<th class="linkHeader">View</th>')
  #$("thead>tr").append $('<th class="linkHeader">Edit</th>')
  #$("thead>tr").append $('<th class="linkHeader">Delete</th>')
  #Store Column Names

    #Add Text to the 'Active Project' Cells
    if $(@).attr('data-label') == "Active Project?"
      $(@).children().each ->
        if $(@) == $("span")
          `console.log("Pass!");`

  columnNames = []
  $('th').each ->
    #If the Column is Empty, set the colspan attribute to null (Allows the new Columns to fit in)

    #Add the Column Name to the Column List
    columnNames.push($(@).text())



  #Apply Column Names to Each Cell in Each Row
  $('tr').each ->
    x = 0
    $(@).children().each ->
      #If the field is empty
      if !$(@).text()
        #Ignore Empty 'Active Project' as this is NOT Empty
        if columnNames[x] == 'Number'
          #Write '-' into the Empty Field
          $(@).text("-") #This fills out the Number Column (stops it from collapsing)
      $(@).attr "data-label", columnNames[x]
      if columnNames[x] == ''
        $(@).attr "class", "tblButton"
        ($(@).next()).attr "class", "tblButton"
        ($(@).next().next()).attr "class", "tblButton"
      x = x + 1

  #Now with Data labels included, use them to add hidden text to the 'Active Project' Cells for Screen Readers
  $('td').each ->
    #Check Data Label
    if $(@).attr('data-label') == "Active project?"
      # Go through the cell's children (should only be one span)
      $(@).children().each ->
        #Check that it is a span
        if $(@).is("span")
          #Check which state it is in (Yes or No)
          if $(@).attr('class') == "text-danger glyphicon glyphicon-remove" #No
            $(@).before ('<p class="hidden">No</p>')
          else if $(@).attr('class') == "text-success glyphicon glyphicon-ok" #Yes
            $(@).before ('<p class="hidden">Yes</p>')


            #courtesy of http://allthingssmitty.com/2016/10/03/responsive-table-layout/

  #Format Links on Pages to add Relevant Icons
  $("a").each ->
    if $(@).text() == 'Show'
      $(@).html('<p>View</p> <span class="text-warning glyphicon glyphicon-eye-open" title=""></span> ')
    else if $(@).text() == 'Edit'
      $(@).html('<p>Edit</p> <span class="text-warning glyphicon glyphicon-pencil" title=""></span> ')
      $(@).attr "class", "tblButton"
    else if $(@).text() == 'Destroy'
      $(@).html('<p>Delete</p> <span class="text-warning glyphicon glyphicon-trash" title=""></span> ')
    else if $(@).text() == 'New Business' || $(@).text() == 'New Contact' || $(@).text() == 'New Project'

      $(@).html('New  <span class="text-warning glyphicon glyphicon-edit" title=""></span>')
      #Move the 'New ...' buttons to the top of the page making them easier to access
      $('h1').after(@) #This now adds it AFTER the h1, as a lone link element
      #$('body').html(@).after('h1')


  #Check 'notice' p tag

  #Find the Element
  $("p").each ->
    #If it has an ID of 'notice'
    if $(@).attr('id') == 'notice'
      #If it is not empty
      if $(@).text().length > 0
        #Leave it Unchanged
      else
        #Otherwise, Hide it
        $(@).attr 'class', 'hidden'

  # Move the Back Button on Indvidual view pages up to the top section
  $("a").each ->
    if $(@).attr('href') == 'javascript:history.back()'
      $(@).html('<span class="text-warning glyphicon glyphicon-chevron-left" title=""></span> Back')
      $('.container').prepend ($(@))

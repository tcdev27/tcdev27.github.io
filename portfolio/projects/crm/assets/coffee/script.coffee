$ ->

  ###
  -----------------------------------------------------------------------------
      1 - General HTML Edits
          - These Are a series of changes made to each page:
          -- Script Tags Moved to Improve Loading.
          -- Meta Tag Added to make bootstrap's Responsive structure work.
          --
  -----------------------------------------------------------------------------
  ###
  # Move Scripts Down
  scripts = $('script')
  $('body').append(scripts)

  #Add Meta Tag for Viewport
  $('head').append('<meta name="viewport" content="width=device-width, initial-scale=1">')

  ###
  -----------------------------------------------------------------------------
      2 - Accessibility Improvments
          - These Are a series of changes made to improve the Accessibility of the Pages and their elements.
           -- Aria Roles added to Tables.
           --
  -----------------------------------------------------------------------------
  ###

  # Select any Tables on the Page and Add Aria Attributes
  table = $ "table"
  table.attr "role", "grid"
  table.attr "aria-colcount", "7" # Add Function for Finding ColCount?

  # Select Table Headers on the Page and Add Aria Attributes
  tableHead = $ "thead"
  tableHead.attr "role", "rowgroup"

  # Select the Table Body on the Page and Add Aria Attributes
  tableBody = $ "tbody"
  tableBody.attr "role", "rowgroup"

  # Select any Table Rows on the Page and Add Aria Attributes
  rows = $ "tr"
  rows.attr "role", "row"

  # Select any Column Headers on the Page and Add Aria Attributes
  headCells = $ "th"
  headCells.attr "role", "columnheader"

  # Select any Table Cells on the Page and Add Aria Attributes
  bodyCells = $ "td"
  bodyCells.attr "role", "gridcell"

  # For Each Column Header, Apply an Incrementing Column Index
  x = 0
  headCells.each ->
    x++
    $(@).attr "aria-colindex", x
  # Use x to set the Number of Columns in the Table for use with the Table Cells
  noColumns = x

  # For Each Table Cell, Apply an Incrementing Column Index
  y = 1
  z = 0
  $('td').each ->
    if y > noColumns
      z = z + 1
      y = noColumns
      if z == 3
        z = 0
        y = 1
    $(@).attr "aria-colindex", y
    y = y + 1

  # Create a List of Column Names for Use in Adding Data-Labels
  columnNames = []
  $('th').each ->
    #Add the Column Name to the Column List
    columnNames.push($(@).text())

  #Apply the Column Names to Each Cell in Each Row as Data Labels
  $('tr').each ->
    x = 0
    # For Each Child Cell in Each Row
    $(@).children().each ->
      # Set the Data-Label to the Relevant Column Name
      $(@).attr "data-label", columnNames[x]
      # Check if the Child Cell Field is Empty
      if !$(@).text()
        # If the empty Field is for 'Number', Add a Placeholder '-'
        if columnNames[x] == 'Number'
          $(@).text("-")
        # Adding the '-' Stops the Cell from Collapsing if empty which causes problems with page structure.
      # When the Loop gets to the blank Column name (Meaning it is at the first of 3 Table Buttons) apply the appropriate class to each of them.
      if columnNames[x] == ''
        $(@).attr "class", "tblButton"
        ($(@).next()).attr "class", "tblButton"
        ($(@).next().next()).attr "class", "tblButton"
      # Loop Back And Increment the Column Name Index
      x = x + 1

  #Now with Data labels included, use them to add hidden text to the 'Active Project' Cells for Screen Readers
  $('td').each ->
    #Check Data Label
    if $(@).attr('data-label') == "Active project?"
      # Go through the cell's children (should only be one span)
      $(@).children().each ->
        #Check that it is a span
        if $(@).is("span")
          #Check which state it is in (Yes or No) and Add Appropriate Text
          if $(@).attr('class') == "text-danger glyphicon glyphicon-remove" #No
            $(@).before ('<p class="hidden">No</p>')
          else if $(@).attr('class') == "text-success glyphicon glyphicon-ok" #Yes
            $(@).before ('<p class="hidden">Yes</p>')

  #Apply the Aria Role 'main' to the container div
  container = $('div[class="container"]')
  container.attr "role", "main"

  #Apply Aria Roles to Bootstrap's divs and other elements?

  ###
  -----------------------------------------------------------------------------
      3 - Usability Improvments
          - These Are a series of changes made to improve the Usability of the Pages and their elements.
           -- Adding Relevant Glyphicons to buttons and links.
           -- Moving Elements to Better Positions
           -- Removing Empty Elements that affect the Page Structure
  -----------------------------------------------------------------------------
  ###

  #Add Appropriate Icons to Some of the Buttons and Links

  # For Each Link, check it's text and determine if a suitable icon can be added
  $("a").each ->
    # Show Button
    if $(@).text() == 'Show'
      $(@).html('<p>View</p> <span class="text-warning glyphicon glyphicon-eye-open" title=""></span> ')
    # Edit Button
    else if $(@).text() == 'Edit'
      $(@).html('<p>Edit</p> <span class="text-warning glyphicon glyphicon-pencil" title=""></span> ')
      $(@).attr "class", "tblButton"
    #Delete Button
    else if $(@).text() == 'Destroy'
      $(@).html('<p>Delete</p> <span class="text-warning glyphicon glyphicon-trash" title=""></span> ')
    #'New' Button (On either of the pages)
    else if $(@).text() == 'New Business' || $(@).text() == 'New Contact' || $(@).text() == 'New Project'
      $(@).html('New  <span class="text-warning glyphicon glyphicon-edit" title=""></span>')
      #Move the 'New' button to the top of the page making it easier to access
      $('h1').after(@)
      #This now moves the new button to be just after the pages first h1 element.


  #Check 'notice' p tag. If it is empty, remove it and prevent it from affecting the page's structure.

  #For Each p tag
  $("p").each ->
    #If it has an ID of 'notice'
    if $(@).attr('id') == 'notice'
      #If it is not empty
      if $(@).text().length > 0
        #Leave it Unchanged
      else
        #Otherwise, Hide it
        $(@).attr 'class', 'hidden'

  # Format and Move the Back Button on Indvidual view pages up to the top of the page

  #For each link
  $("a").each ->
    #if it is a 'back' button (based on href)
    if $(@).attr('href') == 'javascript:history.back()'
      #Reformat it adding a chevron icon
      $(@).html('<span class="text-warning glyphicon glyphicon-chevron-left" title=""></span> Back')
      #Move it to be above the page content container
      $('.container').prepend ($(@))
    # if it is either a 'Sign up' or 'Forgot Password' link
    if $(@).text() == 'Sign up' || $(@).text() == 'Forgot your password?'
      #Move it up to be part of the form it is connected to
      $('form').append(@)

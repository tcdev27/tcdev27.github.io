$ ->

  #Move Scripts Down to bottom of body
  scripts = $('script')
  $('body').append(scripts)

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
  $("thead>tr").append $('<th class="linkHeader">View</th>')
  $("thead>tr").append $('<th class="linkHeader">Edit</th>')
  $("thead>tr").append $('<th class="linkHeader">Delete</th>')
  #Store Column Names
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



            #courtesy of http://allthingssmitty.com/2016/10/03/responsive-table-layout/

    #Replace all Text in Table Links with corresponding icons
    $("a").each ->
      if $(@).text() == 'Show'
        $(@).html('<span class="text-warning glyphicon glyphicon-eye-open" title=""></span> ')
      else if $(@).text() == 'Edit'
        $(@).html('<span class="text-warning glyphicon glyphicon-pencil" title=""></span> ')
      else if $(@).text() == 'Destroy'
        $(@).html('<span class="text-warning glyphicon glyphicon-trash" title=""></span> ')
      else if $(@).text() == 'New Business' || $(@).text() == 'New Contact' || $(@).text() == 'New Project'
        $(@).html('New  <span class="text-warning glyphicon glyphicon-edit" title=""></span>')

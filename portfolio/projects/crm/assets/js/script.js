
/*
-----------------------------------------------------------------------------
    CRM Restyle Scripting - Copyright Tom Chadwick 2017
-----------------------------------------------------------------------------
 */
$(function() {

  /*
  -----------------------------------------------------------------------------
      1 - General HTML Edits
          - These Are a series of changes made to each page:
          -- Script Tags Moved to Improve Loading.
          -- Meta Tag Added to make bootstrap's Responsive structure work.
          --
  -----------------------------------------------------------------------------
   */
  var bodyCells, columnNames, container, headCells, noColumns, rows, scripts, table, tableBody, tableHead, x, y, z;
  scripts = $('script');
  $('body').append(scripts);
  $('head').append('<meta name="viewport" content="width=device-width, initial-scale=1">');

  /*
  -----------------------------------------------------------------------------
      2 - Accessibility Improvments
          - These Are a series of changes made to improve the Accessibility of the Pages and their elements.
           -- Aria Roles added to Tables.
           --
  -----------------------------------------------------------------------------
   */
  table = $("table");
  table.attr("role", "grid");
  table.attr("aria-colcount", "7");
  tableHead = $("thead");
  tableHead.attr("role", "rowgroup");
  tableBody = $("tbody");
  tableBody.attr("role", "rowgroup");
  rows = $("tr");
  rows.attr("role", "row");
  headCells = $("th");
  headCells.attr("role", "columnheader");
  bodyCells = $("td");
  bodyCells.attr("role", "gridcell");
  x = 0;
  headCells.each(function() {
    x++;
    return $(this).attr("aria-colindex", x);
  });
  noColumns = x;
  y = 1;
  z = 0;
  $('td').each(function() {
    if (y > noColumns) {
      z = z + 1;
      y = noColumns;
      if (z === 3) {
        z = 0;
        y = 1;
      }
    }
    $(this).attr("aria-colindex", y);
    return y = y + 1;
  });
  columnNames = [];
  $('th').each(function() {
    return columnNames.push($(this).text());
  });
  $('tr').each(function() {
    x = 0;
    return $(this).children().each(function() {
      $(this).attr("data-label", columnNames[x]);
      if (!$(this).text()) {
        if (columnNames[x] === 'Number') {
          $(this).text("-");
        }
      }
      if (columnNames[x] === '') {
        $(this).attr("class", "tblButton");
        ($(this).next()).attr("class", "tblButton");
        ($(this).next().next()).attr("class", "tblButton");
      }
      return x = x + 1;
    });
  });
  $('td').each(function() {
    if ($(this).attr('data-label') === "Active project?") {
      return $(this).children().each(function() {
        if ($(this).is("span")) {
          if ($(this).attr('class') === "text-danger glyphicon glyphicon-remove") {
            return $(this).before('<p class="hidden">No</p>');
          } else if ($(this).attr('class') === "text-success glyphicon glyphicon-ok") {
            return $(this).before('<p class="hidden">Yes</p>');
          }
        }
      });
    }
  });
  container = $('div[class="container"]');
  container.attr("role", "main");

  /*
  -----------------------------------------------------------------------------
      3 - Usability Improvments
          - These Are a series of changes made to improve the Usability of the Pages and their elements.
           -- Adding Relevant Glyphicons to buttons and links.
           -- Moving Elements to Better Positions
           -- Removing Empty Elements that affect the Page Structure
  -----------------------------------------------------------------------------
   */
  $("a").each(function() {
    if ($(this).text() === 'Show') {
      return $(this).html('<p>View</p> <span class="text-warning glyphicon glyphicon-eye-open" title=""></span> ');
    } else if ($(this).text() === 'Edit') {
      $(this).html('<p>Edit</p> <span class="text-warning glyphicon glyphicon-pencil" title=""></span> ');
      return $(this).attr("class", "tblButton");
    } else if ($(this).text() === 'Destroy') {
      return $(this).html('<p>Delete</p> <span class="text-warning glyphicon glyphicon-trash" title=""></span> ');
    } else if ($(this).text() === 'New Business' || $(this).text() === 'New Contact' || $(this).text() === 'New Project') {
      $(this).html('New  <span class="text-warning glyphicon glyphicon-edit" title=""></span>');
      return $('h1').after(this);
    }
  });
  $("p").each(function() {
    if ($(this).attr('id') === 'notice') {
      if ($(this).text().length > 0) {

      } else {
        return $(this).attr('class', 'hidden');
      }
    }
  });
  return $("a").each(function() {
    if ($(this).attr('href') === 'javascript:history.back()') {
      $(this).html('<span class="text-warning glyphicon glyphicon-chevron-left" title=""></span> Back');
      $('.container').prepend($(this));
    }
    if ($(this).text() === 'Sign up' || $(this).text() === 'Forgot your password?') {
      return $('form').append(this);
    }
  });
});

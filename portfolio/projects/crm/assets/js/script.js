$(function() {
  var bodyCells, columnNames, headCells, rows, scripts, table, tableBody, tableHead, x, y;
  scripts = $('script');
  $('body').append(scripts);
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
  x = 1;
  $('th').each(function() {
    $(this).attr("aria-colindex", x);
    return x = x + 1;
  });
  y = 1;
  $('td').each(function() {
    if (y > 7) {
      y = 1;
    }
    $(this).attr("aria-colindex", y);
    return y = y + 1;
  });
  $("thead>tr").append($('<th class="linkHeader">View</th>'));
  $("thead>tr").append($('<th class="linkHeader">Edit</th>'));
  $("thead>tr").append($('<th class="linkHeader">Delete</th>'));
  columnNames = [];
  $('th').each(function() {
    return columnNames.push($(this).text());
  });
  return $('tr').each(function() {
    x = 0;
    $(this).children().each(function() {
      if (!$(this).text()) {
        if (columnNames[x] === 'Number') {
          $(this).text("-");
        }
      }
      $(this).attr("data-label", columnNames[x]);
      if (columnNames[x] === '') {
        $(this).attr("class", "tblButton");
        ($(this).next()).attr("class", "tblButton");
        ($(this).next().next()).attr("class", "tblButton");
      }
      return x = x + 1;
    });
    return $("a").each(function() {
      if ($(this).text() === 'Show') {
        return $(this).html('<span class="text-warning glyphicon glyphicon-eye-open" title=""></span> ');
      } else if ($(this).text() === 'Edit') {
        return $(this).html('<span class="text-warning glyphicon glyphicon-pencil" title=""></span> ');
      } else if ($(this).text() === 'Destroy') {
        return $(this).html('<span class="text-warning glyphicon glyphicon-trash" title=""></span> ');
      } else if ($(this).text() === 'New Business' || $(this).text() === 'New Contact' || $(this).text() === 'New Project') {
        return $(this).html('New  <span class="text-warning glyphicon glyphicon-edit" title=""></span>');
      }
    });
  });
});

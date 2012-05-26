$(function()
{
  var hideDelay = 500;  
  var currentID;
  var hideTimer = null;

  // One instance that's reused to show info for the current person
  var container = $('<div id="tooltipContainer">'
      + '<table width="" border="0" cellspacing="0" cellpadding="0" align="center" class="tooltipPopup">'
      + '<tr>'
      + '   <td class="corner topLeft"></td>'
      + '   <td class="top"></td>'
      + '   <td class="corner topRight"></td>'
      + '</tr>'
      + '<tr>'
      + '   <td class="left">&nbsp;</td>'
      + '   <td><div id="tooltipPopupContent"></div></td>'
      + '   <td class="right">&nbsp;</td>'
      + '</tr>'
      + '<tr>'
      + '   <td class="corner bottomLeft">&nbsp;</td>'
      + '   <td class="bottom">&nbsp;</td>'
      + '   <td class="corner bottomRight"></td>'
      + '</tr>'
      + '</table>'
      + '</div>');

  $('body').append(container);

  $('.tooltipTrigger').live('mouseover', function()
  {

      // format of 'href' property: object, id  
      var settings = $(this).attr('href').split('/');  
      var object = settings[1];  
      var currentID = settings[2]; 

      if (hideTimer)
          clearTimeout(hideTimer);

      var pos = $(this).offset();
      var width = $(this).width();
      container.css({
          left: (pos.left + width) + 'px',
          top: pos.top - 5 + 'px'
      });

      $('#tooltipPopupContent').html('&nbsp;');

      $.ajax({
          type: 'GET',
          url: $(this).attr('href'),
          data: 'tooltip=true',
          success: function(data)
          {
            $('#tooltipPopupContent').html(data);
          },
          error: function(xhr, status, error)
          {
            $('#tooltipPopupContent').html('Ajax error: '+xhr.responseText);
          }
      });

      container.css('display', 'block');
  });
  $('.tooltipTrigger').live('mouseout', function()
  {
      if (hideTimer)
          clearTimeout(hideTimer);
      hideTimer = setTimeout(function()
      {
         container.css('display', 'none');
      }, hideDelay);
  });

  // Allow mouse over of details without hiding details
  $('#tooltipContainer').mouseover(function()
  {
      if (hideTimer)
          clearTimeout(hideTimer);
  });

  // Hide after mouseout
  $('#tooltipContainer').mouseout(function()
  {
      if (hideTimer)
          clearTimeout(hideTimer);
      hideTimer = setTimeout(function()
      {
          container.css('display', 'none');
      }, hideDelay);
  });
});


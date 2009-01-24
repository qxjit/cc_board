css = new CSS();
allow_refresh = false;

function enableRefresh() {
  if(!allow_refresh) { 
    allow_refresh = true;
    setTimeout(function() { if(allow_refresh) {window.location.href = window.location.href} }, 10000);
  }
}

function disableRefresh() {
  allow_refresh = false;
}

function openSettingsPanel() {
  disableRefresh();
  $('settings_panel').style.visibility = 'visible';
}

function closeSettingsPanel() {
  enableRefresh();
  $('settings_panel').style.visibility = 'hidden';
}

function changeTextSize(size) {
  css.add_rules({
    '.build' : {
      'font-size' : size + '%'
    }
  });
  css.refresh();
  $('text_size_input').value = size;
  Cookie.write('font-size-setting', size, {duration: 365});
}

window.onload = function() {
  enableRefresh();

  if(Cookie.read('font-size-setting')) {
    changeTextSize(Cookie.read('font-size-setting'));
  }
}


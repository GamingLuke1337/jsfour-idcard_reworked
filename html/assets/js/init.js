$(document).ready(function(){
  // LUA listener
  window.addEventListener('message', function( event ) {
    if (event.data.action == 'open') {
      var type        = event.data.type;
      var userData    = event.data.array['user'][0];
      var licenseData = event.data.array['licenses'];
      var sex         = userData.sex;

      if ( type == 'driver' || type == null) {
        $('img').show();
        $('#name').css('color', '#282828');

        if ( sex.toLowerCase() == 'm' ) {
          $('img').attr('src', 'assets/images/male.png');
          $('#sex').text('male');
        } else {
          $('img').attr('src', 'assets/images/female.png');
          $('#sex').text('female');
        }

        $('#namefirst').text(userData.firstname);
        $('#namelast').text(userData.lastname);
        $('#dob').text(userData.dateofbirth);
        $('#height').text(userData.height);
        $('#signature').text(userData.firstname + ' ' + userData.lastname);

        if ( type == 'driver' ) {
          if ( licenseData != null ) {
          Object.keys(licenseData).forEach(function(key) {
            var type = licenseData[key].type;

            if ( type == 'drive_bike') {
              type = 'Klasse A';
            } else if ( type == 'drive_truck' ) {
              type = 'Klasse CE';
            } else if ( type == 'drive' ) {
              type = 'Klasse B';
            } else if ( type == 'drive_bus' ) {
              type = 'Klasse D';
            } else if ( type == 'drive_truck_hvy' ) {
              type = 'Klasse C1E';
            } else if ( type == 'fly' ) {
              type = 'Cargo';
            }  else if ( type == 'fly_jet' ) {
              type = 'Privat';
            }

            if ( type == 'Klasse A' || type == 'Klasse CE' || type == 'Klasse B' || type == 'Klasse D' || type == 'Klasse C1E' || type == 'Cargo' || type == 'Privat') {
              $('#licenses').append('<p>'+ type +'</p>');
            }
          });
        }

          $('#id-card').css('background', 'url(assets/images/license.png)');
        } else {
          $('#id-card').css('background', 'url(assets/images/idcard.png)');
        }
      } else if ( type == 'weapon' ) {
        $('img').hide();
        $('#name').css('color', '#d9d9d9');
        $('#namefirst').text(userData.firstname);
        $('#namelast').text(userData.lastname);
        $('#dob').text(userData.dateofbirth);
        $('#signature').text(userData.firstname + ' ' + userData.lastname);

        $('#id-card').css('background', 'url(assets/images/firearm.png)');
      }

      $('#id-card').show();
    } else if (event.data.action == 'close') {
      $('#name').text('');
      $('#dob').text('');
      $('#height').text('');
      $('#signature').text('');
      $('#sex').text('');
      $('#id-card').hide();
      $('#licenses').html('');
    }
  });
});

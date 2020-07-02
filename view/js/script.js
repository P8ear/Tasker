
$(document).delegate('#logInBtt', 'click', function(){
	let login = $('#loginForm input[name="username"]').val();
	let pwd =  $('#loginForm input[name="password"]').val();
	let error = '';
	
	$('#loginForm .alert').fadeOut(100, function(){
		$(this).remove();
	});
	
	if(typeof login == 'undefined' || login === "") {
		error += 'Введите Ваш логин<br>';
	}
	if(typeof pwd == 'undefined' || pwd === "") {
		error += 'Введите Ваш пароль<br>';
	}
	
	if(error != '') {
		$('#loginForm .modal-body').append('<div class="alert alert-danger " style="display:none;">'+error+'</div>');
		$('#loginForm .alert').fadeIn(50);
	} else {
		$.ajax({
			url: '/?route=user/login',
			data: {username: login, password: pwd},
			type: 'POST',
			dataType: 'JSON',
			beforeSend: function() {
				$('#logInBtt').prepend('<i class="fa fa-cog fa-spin  fa-fw"></i>');
			},
			complete: function(){
				$('#logInBtt .fa').fadeOut(100, function(){
					$(this).remove();
				});
			},
			error: function(xhr, ajaxOptions, thrownError) {
	            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	        },
			success: function(json) {
				if(json.success) {
					if(window.location.pathname != '/?route=user/logout') {
						location.reload();
					} else {
						window.location = '/';
					}
				}
				if(json.error) {
					$('#loginForm .modal-body').append('<div class="alert alert-danger  " style="display:none;">'+json.error+'</div>');
					$('#loginForm .alert').fadeIn(100);
				}
			}
		});
	}
	
});
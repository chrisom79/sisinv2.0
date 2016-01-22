/**
 * 
 */
$(document).ready(function() {
			$("#search").autocomplete({
				source : function (request, response) {
					$.ajax({
						url:"ProductoAction",
						type:"POST",
						data:{
							term : request.productos
						},
						dataType: "json",
						success : function (data) {
							response(data);
						}
					});
				}
			});
});
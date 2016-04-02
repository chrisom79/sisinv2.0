<div class="row">
	<div class="col-lg-12">
	 	<div class="form-group">
            <label>Nombre</label>
            <input class="form-control" name="txtNombre" value="${vend.nombre}">
        </div>
    </div>
</div>
<div class="row">
 		 	<div class="col-lg-12">
  		 	<div class="form-group">
                    <label>Dirección</label>
                    <input class="form-control" name="txtDireccion" value="${vend.direccion}">
                </div>
            </div>
</div>
<div class="row">
 		 	<div class="col-lg-8">
 		 		<label>Email</label>
  		 	<div class="form-group input-group">
                    <span class="input-group-addon">@</span>
                    <input type="text" class="form-control" name="txtEmail" value="${vend.email}">
                </div>
            </div>
            <div class="col-lg-5">
  		 	<div class="form-group">
                    <label>Telefono</label>
                    <input class="form-control" name="txtTelefono" value="${vend.telefono}">
                </div>
            </div>
</div>
<div class="row">
	<div class="col-lg-5">
  		 	<div class="form-group">
                    <label>Usuario</label>
                    <input class="form-control" name="txtUsuario" value="${vend.usuario}">
                </div>
            </div>
            <div class="col-lg-5">
            	<label>Comision</label>
  		 	<div class="form-group input-group">
  		 		<span class="input-group-addon">%</span>
                    <input class="form-control" name="txtComision" value="${vend.comision}">
                </div>
            </div>
</div>
<div class="row">
	<div class="col-lg-12">
	 	<div class="form-group">
            <label>Nombre</label>
            <input type="text" class="form-control" id="txtNombre" name="txtNombre" value="${vend.nombre}">
        </div>
    </div>
</div>
<div class="row">
	<div class="col-lg-12">
  		<div class="form-group">
        	<label>Dirección</label>
            <input type="text" class="form-control" id="txtDireccion" name="txtDireccion" value="${vend.direccion}">
        </div>
    </div>
</div>
<div class="row">
 		 	<div class="col-lg-8">
 		 		<label>Email</label>
  		 	<div class="form-group input-group">
                    <span class="input-group-addon">@</span>
                    <input type="text" type="text" class="form-control" id="txtEmail" name="txtEmail" value="${vend.email}">
                </div>
            </div>
            <div class="col-lg-5">
  		 	<div class="form-group">
                    <label>Telefono</label>
                    <input type="text" class="form-control" id="txtTelefono" name="txtTelefono" value="${vend.telefono}">
                </div>
            </div>
</div>
<div class="row">
	<div class="col-lg-5">
  		 	<div class="form-group">
                    <label>Usuario</label>
                    <input type="text" class="form-control" id="txtUsuario" name="txtUsuario" value="${vend.usuario}">
                </div>
            </div>
            <div class="col-lg-5">
            	<label>Comision</label>
  		 	<div class="form-group input-group">
  		 		<span class="input-group-addon">%</span>
                    <input type="text" class="form-control" id="txtComision" name="txtComision" value="${vend.comision}">
                </div>
            </div>
</div>
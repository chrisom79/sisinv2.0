<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="row">
	<div class="col-lg-8">
		<div class="form-group">
        	<label>Código</label>
            <input class="form-control" id="txtCodigo" name="txtCodigo" value="${prod.id}">
        </div>
    </div>
</div>
<div class="row">
 		 	<div class="col-lg-12">
  		 	<div class="form-group">
                    <label>Nombre</label>
                    <input class="form-control" name="txtNombre" value="${prod.nombre}">
                </div>
            </div>
</div>
<div class="row">
 		 	<div class="col-lg-5">
 		 		<label>Precio compra</label>
  		 	<div class="form-group input-group">
                    <span class="input-group-addon">$</span>
                    <input type="text" class="form-control" name="txtPrecioComp" value="${prod.precioCompra}">
                </div>
            </div>
            <div class="col-lg-3">
            	<label>Ganancia</label>
  		 	<div class="form-group input-group">
  		 		
                    <span class="input-group-addon">%</span>
                    <input type="text" class="form-control" name="txtGanancia" value="${prod.porcentaje}">
                </div>
            </div>
            <div class="col-lg-3">
  		 	<div class="form-group">
  		 		<label>
                        <input id="chkIVA" type="checkbox" value="true" name="txtIVA" <c:if test="${prod.iva}">checked</c:if>> IVA
                    </label>
                </div>
            </div>
</div>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="row">
	<div class="col-lg-12">
		<div class="form-group">
        	<label>Nombre de la oferta</label>
            <input class="form-control" id="txtNombre" name="txtNombre" value="${oferta.descripcion}">
        </div>
    </div>
</div>
<div class="row">
	<div class="col-lg-8">
		<div class="form-group">
        	<label>Tipo</label>
        	<div class="radio">
        		<label>
            		<input type="radio" name="tipo" value="desc" <c:if test="${oferta.tipo eq 1 or empty oferta.tipo}">checked</c:if>/> Descuento
            	</label>
            </div>
            <div class="radio">
            	<label>
            		<input type="radio" name="tipo" value="compra-lleva" <c:if test="${oferta.tipo eq 2}">checked</c:if>/> Compra-Llevate
            	</label>
            </div>
             <div class="radio">
            	<label>
            		<input type="radio" name="tipo" value="compra-por" <c:if test="${oferta.tipo eq 3}">checked</c:if>/> Compra-Por
            	</label>
            </div>
    	</div>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
 		<div  class="form-group">
 			<label>Producto en oferta</label>
             <input id="searchProd" class="form-control" type="text" placeholder="Nombre del producto" value="${oferta.producto.nombre}">
         </div>
     </div>
</div>
<div class="row">
	<div id="div-desc" class="col-lg-5" <c:if test="${oferta.tipo ne 1 and not empty oferta.tipo}">style="display: none;" </c:if>>
		<label>Descuento</label>
		<div class="form-group input-group">
              <span class="input-group-addon">%</span>
              <input type="text" class="form-control" name="txtDescuento" value="${oferta.descuento}">
        </div>
    </div>
</div>
<div class="row">
	<div id="div-compralleva" class="col-lg-8" <c:if test="${oferta.tipo ne 2}">style="display: none;"</c:if>>
		<label>Oferta en grupo</label>
		<div class="form-group input-group">
              <span class="input-group-addon">Compra</span>
              <input type="text" class="form-control" name="txtCompra" value="${oferta.compra}">
              <span class="input-group-addon">Llevate</span>
              <input type="text" class="form-control" name="txtLlevate" value="${oferta.lleva}">
        </div>
    </div>
</div>
<div class="row">
	<div id="div-comprapor" class="col-lg-8" <c:if test="${oferta.tipo ne 3}">style="display: none;"</c:if>>
		<label>Oferta en grupo</label>
		<div class="form-group input-group">
              <span class="input-group-addon">Compra</span>
              <input type="text" class="form-control" name="txtCompra2" value="${oferta.compra}">
              <span class="input-group-addon">Por $</span>
              <input type="text" class="form-control" name="txtPor" value="${oferta.por}">
        </div>
    </div>
</div>
<div class="row">
	<div id="div-precio" class="col-lg-5" style="display: none;">
		<label>Precio de la oferta</label>
		<div class="form-group input-group">
              <span class="input-group-addon">$</span>
              <input type="text" class="form-control" name="txtPrecio" value="">
        </div>
    </div>
</div>

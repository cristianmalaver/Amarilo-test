<?php
session_start();

if (!isset($_SESSION['User'])) {
  header("../../pages/login/login.html");
} else {
  $var_session  = $_SESSION['User'];
}
?>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Crear Producto</title>
  <!-- css link -->
  <?php include("../../php/viewHtml/cssLink.php") ?>
  <link href="css/styleObligation.css" rel="stylesheet">
</head>

<body id="page-top">
  <div class="loadPage" id="loadPage"></div>
  <input type="hidden" id="User_id">
  <!--Alert-->
  <div id="myAlert"></div>
  <!--Alert-->
  <!-- Page Wrapper -->
  <div id="wrapper">

    <!-- Sidebar -->
    <?php include("../../php/viewHtml/slideMenu.php") ?>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <!-- Topbar -->
        <?php include("../../php/viewHtml/navUser.php") ?>
        <!-- End of Topbar -->

        <!-- Topbar -->
        <?php include("../../php/viewHtml/topbar.php") ?>
        <!-- End of Topbar -->

        <!-- Begin Page Content -->

        <div class="container-fluid">
          <br>
          <!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800">Crear Productos</h1>

          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">

              <ul class="nav nav-pills card-header-pills">
                <li class="nav-item">
                  <div class="ml-4">
                    <button class="btn btn-secondary" data-toggle="modal" data-target="#customerModal" onclick="clearForm('form_customers', 1);newObligation()"><i style="font-size: 2rem; padding:5px;" class="material-icons">add_box</i></button>
                  </div>
                </li>
              </ul>
              <div class="text-center">
                <h4 class="m-0 font-weight-bold text-primary">Productos Creados</h4>
              </div>
            </div>
            <div class=" mx-auto col-md-6 align-self-center">
              <form class="navbar-form" id="formSearchObligation">
                <div class="input-group ">
                  
                
                    <div class="ripple-container"></div>
                  </button>
                </div>
              </form>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table  " data-order='[[ 1, "asc" ]]' data-page-length='25' id="tableObligation" width="100%" cellspacing="0">
                </table>
              </div>
            </div>
          </div>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

      <!-- Footer -->
      <footer class="sticky-footer bg-white">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright &copy; <script>
                document.write(new Date().getFullYear());
              </script> | amarilo. </span>

          </div>
        </div>
      </footer>
      <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- delete Modal-->
  <div class="modal fade" id="deleteObj" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="delete">seguro quieres eliminar esta persona?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Selecciona "Borrar" para eliminar esta peronsa.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
          <a class="btn btn-primary" href="/obligation/obligation.php">Borrar</a>
        </div>
      </div>
    </div>
  </div>
  <!-- Modal -->
  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">¿Seguro que quieres salir?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Selecciona "Cerrar sesión" a continuación si está listo para finalizar su sesión personal.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
          <a class="btn btn-primary" href="../../php/class/closeSession.php" onclick="closeSession()">Cerrar Sessión</a>
        </div>
      </div>
    </div>
  </div>
  <!-- Modal -->
  <div class="modal fade fullscreen-modal" id="customerModal" tabindex="-1" role="dialog" aria-labelledby="customerModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="customerModalLabel">Obligación </h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="col-md-12">


            <form id="form_customers" class="text-left  was-validated" action="#!" onsubmit="sendData(this.id,event);return false">
              <input type="hidden" id="obligation_id">


              <div class="form-row mb-1">




                <div class="col-md-4 mb-1">
                  <!-- Obligación -->
                  <div class="bmd-label-floating">
                    <h6 class="bmd-label-floating">Nombre pèrsona</h6>
                    <input type="text" id="obligation_cod" class="form-control form-control-sm read" placeholder="Ingresar nombre " required>
                    <div class="valid-feedback">Ok!</div>
                    <div class="invalid-feedback">Proporcione código</div>
                  </div>
                </div>


               <div class="col-md-4 mb-1">
                   <!--Obligación -->
                  <div class="bmd-label-floating">
                    <h6 for="client_idmax">Apellido</h6>
                    <input type="text" id="client_idmax" class="form-control form-control-sm read" placeholder="Ingresar referencia " required>
                    <div class="valid-feedback">Ok!</div>
                    <div class="invalid-feedback">Proporcione un dato valido</div>
                  </div>
                </div>

                <div class="col-md-4 mb-1">
                   <!--Obligación -->
                  <div class="bmd-label-floating">
                    <h6 for="client_contract">fecha de nacimiento</h6>
                    <input type="date" id="client_contract" class="form-control form-control-sm read" placeholder="Ingresar referencia " required>
                    <div class="valid-feedback">Ok!</div>
                    <div class="invalid-feedback">Proporcione un dato valido</div>
                  </div>
                </div>

              </div>
          
            <div class="form-row mb-1">

      

                <div class="col-md-4 mb-1">
                
              
                <!-- ------------ antigua-->
                    <h6 for="obligation_antigua">ROL</h6>
                    <select id="obligation_antigua" class="custom-select custom-select-sm " placeholder="Ingresar valor " required>
                      <option disabled selected value> -- Seleccione una opción -- </option>
                      <option value="1">admin</option>
                      <option value="2">normal person</option>
                      </select>
                    <div class="valid-feedback">Ok!</div>
                    <div class="invalid-feedback">Proporcione un valor válido.</div>
                  </div>



              <div class="col-md-4 mb-1">
                
              
              <!-- ------------ antigua-->
                  <h6 for="category">tiene hermanos?</h6>
                  <select id="category" class="custom-select custom-select-sm " placeholder="Ingresar valor " required>
                    <option disabled selected value> -- Seleccione una opción -- </option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                  </select>
                  <div class="valid-feedback">Ok!</div>
                  <div class="invalid-feedback">Proporcione un valor válido.</div>
                </div>
           
       

                <div class="col-md-4 mb-1">
                
              
                <!-- ------------ antigua-->
                    <h6 for="credit_type_id">estado civil</h6>
                    <select id="credit_type_id" class="custom-select custom-select-sm " placeholder="Ingresar valor " required>
                      <option disabled selected value> -- Seleccione una opción -- </option>
                      <option value="1">soltero</option>
                      <option value="2">casado</option>
                      <option value="3">N/A</option>
                      </select>
                    <div class="valid-feedback">Ok!</div>
                    <div class="invalid-feedback">Proporcione un valor válido.</div>
                  </div>


                

            </div>

              
            </form>

          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
          <button type="submit" class="btn btn-primary" value="Submit" form="form_customers">Guardar</button>
        </div>
      </div>
    </div>
  </div>
  

  <!-- Bootstrap core JavaScript-->
  <script src="../../vendor/jquery/jquery.min.js"></script>
  <script src="../../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="../../vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="../../js/sb-admin-2.min.js"></script>
  <!-- Table amortization-->


  <!-- Page functión scripts -->
  <!-- Page level plugins -->
  <script src="../../vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="../../vendor/datatables/dataTables.bootstrap4.min.js"></script>



  <!-- Page level custom scripts -->

  <script src="../../js/functionsSite.js"></script>
  <script src="../../js/Storage.js"></script>
  <script src="../../js/table-filter.js"></script>
  <script src="../../js/table.js"></script>
  <script src="../../js/tableAmortization.js"></script>
  <script src="../../js/moment.js"></script>
  <script src="../../js/selectList.js"></script>
  <script type="text/javascript" src="js/obligation.js"></script>
  <script type="text/javascript" src="js/contract.js"></script>
  <script type="text/javascript" src="../../js/formatNumber.js"></script>
  <script>
    window.onload = loadView;
  </script>



</body>

</html>
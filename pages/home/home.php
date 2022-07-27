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

  <title>Crear persona</title>
  <!-- css link -->
  <?php include("../../php/viewHtml/cssLink.php") ?>

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

        <!-- navUser -->
        <?php include("../../php/viewHtml/navUser.php") ?>
        <!-- End of navUser -->

        <!-- Topbar -->
        <?php include("../../php/viewHtml/topbar.php") ?>
        <!-- End of Topbar -->

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
          <h5 class="modal-title" id="delete">seguro quieres eliminar esta obligaacion?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Selecciona "Borrar" para eliminar esta obligacion.</div>
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
          <a class="btn btn-primary" href="../../php/class/closeSession.php" onclick="closeSession()" >Cerrar Sessión</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal -->
  <div class="modal fade fullscreen-modal" id="payModal" tabindex="-1" role="dialog" aria-labelledby="payModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="payModalLabel">PAGOS</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="col-md-12">
            <form id="form_payModal" class="text-left  was-validated" action="#!" onsubmit="sendData(this.id,event);return false">
              <input type="number" id="pay_obligation_id" style="visibility:hidden">
              <h5>Desea realizar el siguiente pago?</h5>
              <div class="form-row mb-1">
                <div class="col-md-4 mb-1">
                  <!-- Codigo -->
                  <label class="bmd-label-floating"> Codigo de Obligacion </label>
                  <input type="text" id="obligation_cod" class="form-control form-control-sm read">
                </div>
                <div class="col-md-4 mb-1">
                  <!-- # de pago -->
                  <label class="bmd-label-floating"># de pago</label>
                  <input type="text" id="pay_obligation_actual_cuote" class="form-control form-control-sm read">

                </div>

                <div class="col-md-4 mb-1">
                  <!-- dtf -->
                  <label class="bmd-label-floating"> dtf de fecha</label>
                  <input type="text" id="pay_Dtf" class="form-control form-control-sm read ">
                </div>
              </div>
              <div class="form-row mb-1">
                <div class="col-md-4 mb-1 ">
                  <!-- ibr -->
                  <label class="bmd-label-floating"> ibr de fecha</label>
                  <input type="text" id="pay_Ibr" class="form-control form-control-sm read">
                </div>
                <div class="col-md-4 mb-1 ">
                  <!-- tasa fija -->
                  <label class="bmd-label-floating"> tasa fija</label>
                  <input type="text" id="pay_FixedRate" class="form-control form-control-sm read">

                </div>

                <div class="col-md-4 mb-1">
                  <!-- Fecha -->
                  <label class="bmd-label-floating"> Fecha</label>
                  <input type="date" id="pay_Date" class="form-control form-control-sm read">
                </div>
              </div>

              <div class="form-row mb-1">

                <div class="col-md-3 mb-1">
                  <!-- pago a capital -->
                  <label class="bmd-label-floating"> Monto a capital</label>
                  <input type="text" id="pay_capital_value" class="form-control form-control-sm read">

                </div>

                <div class="col-md-3 mb-1">
                  <!-- deuda -->
                  <label class="bmd-label-floating"> deuda</label>
                  <input type="text" id="pay_residue" class="form-control form-control-sm read">

                </div>
                <div class="col-md-3 mb-1">
                  <!-- Monto a interes -->
                  <label class="bmd-label-floating"> Monto a interes</label>
                  <input type="text" id="pay_interesting_value" class="form-control form-control-sm read">

                </div>
                
                <div class="col-md-3 mb-1">
                  <!-- monto -->
                  <label class="bmd-label-floating"> Monto a pagar</label>
                  <input type="text" id="pay_value" class="form-control form-control-sm read">

                </div>
              </div>
              <div class="form-row mb-1">
                <div class="col-md-12 mb-1">
                  <!-- observaciones del pago -->
                  <label class="bmd-label-floating"> observaciones del pago</label>
                  <input type="text" id="pay_observation" class="form-control form-control-sm">

                </div>
                
              </div>

              <!-- -->

            </form>
            <div class="form-row mb-1">
              <div class="col-md-4 mb-1">
                <!-- Nombre -->
                <label class="bmd-label-floating"> Nombre de cliente </label>
                <input type="text" id="client_name" disabled class="form-control form-control-sm read">
              </div>
              <div class="col-md-4 mb-1">
                <!-- Estado -->
                <label class="bmd-label-floating"> Estado</label>
                <input type="text" id="Stat_name" disabled class="form-control form-control-sm read ">

              </div>

              <div class="col-md-4 mb-1">
                <!-- Banco -->
                <label class="bmd-label-floating"> Banco</label>
                <input type="text" id="Bank_name" disabled class="form-control form-control-sm read">
              </div>
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary" value="Submit" form="form_payModal">Pagar</button>
          </div>
        </div>
      </div>
    </div>

  
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
          <a class="btn btn-primary" href="../../php/class/closeSession.php" onclick="closeSession()" >Cerrar Sessión</a>
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
  <script type="text/javascript" src="js/payObligation.js"></script>
  <script type="text/javascript" src="../../js/formatNumber.js"></script>
  <script>
    window.onload = loadView;
  </script>



</body>

</html>
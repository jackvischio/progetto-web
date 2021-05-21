/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.unitn.disi.wp.servizioSanitario.servletsDottore;

import it.unitn.disi.wp.servizioSanitario.dao.DAOFactory;
import it.unitn.disi.wp.servizioSanitario.dao.exceptions.DaoException;
import it.unitn.disi.wp.servizioSanitario.dao.exceptions.NotFoundDAOException;
import it.unitn.disi.wp.servizioSanitario.dao.interfaces.DispositionDAO;
import it.unitn.disi.wp.servizioSanitario.dao.interfaces.DistrictDAO;
import it.unitn.disi.wp.servizioSanitario.dao.interfaces.DottoreDAO;
import it.unitn.disi.wp.servizioSanitario.dao.interfaces.DrugDAO;
import it.unitn.disi.wp.servizioSanitario.dao.interfaces.ExamDAO;
import it.unitn.disi.wp.servizioSanitario.dao.interfaces.FarmaciaDAO;
import it.unitn.disi.wp.servizioSanitario.dao.interfaces.ListaVisiteDAO;
import it.unitn.disi.wp.servizioSanitario.dao.interfaces.PazienteDAO;
import it.unitn.disi.wp.servizioSanitario.dao.interfaces.PhotoDAO;
import it.unitn.disi.wp.servizioSanitario.dao.interfaces.PrescriptionDAO;
import it.unitn.disi.wp.servizioSanitario.dao.interfaces.SpeckvisitDAO;
import it.unitn.disi.wp.servizioSanitario.dao.interfaces.VisitDAO;
import it.unitn.disi.wp.servizioSanitario.dao.mysql.DAOFactoryImplementation;
import it.unitn.disi.wp.servizioSanitario.entities.District;
import it.unitn.disi.wp.servizioSanitario.entities.Dottore;
import it.unitn.disi.wp.servizioSanitario.entities.Exam;
import it.unitn.disi.wp.servizioSanitario.entities.Farmacia;
import it.unitn.disi.wp.servizioSanitario.entities.Paziente;
import it.unitn.disi.wp.servizioSanitario.entities.Photo;
import it.unitn.disi.wp.servizioSanitario.entities.Prescription;
import it.unitn.disi.wp.servizioSanitario.entities.User;
import it.unitn.disi.wp.servizioSanitario.entities.Visit;
import it.unitn.disi.wp.servizioSanitario.entities.utils.ExamChs;
import it.unitn.disi.wp.servizioSanitario.entities.utils.PrescriptionChs;
import it.unitn.disi.wp.servizioSanitario.entities.utils.SpeckvisitChs;
import it.unitn.disi.wp.servizioSanitario.entities.utils.TypeDoctor;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author simmf
 */
public class DettaglioPaziente extends HttpServlet {

    DAOFactory daoFactory;
    private SpeckvisitDAO speckvisitDao;
    private PazienteDAO pazienteDao;
    private VisitDAO visitDao;
    private DistrictDAO districtDao;
    private PrescriptionDAO prescriptionDao;
    private ExamDAO examDao;
    private PhotoDAO photoDao;
    private Paziente paziente;
    private District district;
    private Paziente familyDoctor;
    private List<Visit> visite;
    private List <PrescriptionChs> prescriptions;
    private List <ExamChs> exams;
    private List <SpeckvisitChs> speckvisits;
    private DottoreDAO dottoreDao;
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, DaoException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            HttpSession session = request.getSession();
            
            daoFactory = new DAOFactoryImplementation();
            pazienteDao = daoFactory.getPazienteDAO();
            districtDao = daoFactory.getDistrictDAO();
            visitDao = daoFactory.getVisitDAO();
            prescriptionDao = daoFactory.getPrescriptionDAO();
            examDao = daoFactory.getExamDAO();
            speckvisitDao = daoFactory.getSpeckvisitDAO();
            photoDao = daoFactory.getPhotoDAO();
            dottoreDao = daoFactory.getDottoreDAO();
            
            //url: .../DettaglioPaziente?pazienteId=xxx
            
            //prendo l'id del paziente di cui voglio vedere le informazioni
            int pazienteId = 0;
            try{
                pazienteId = Integer.parseInt( request.getParameter("pazienteId") );
            } catch(Exception ex){
                daoFactory.closeConn();
                request.getRequestDispatcher("/WEB-INF/pagine/err404.jsp").forward(request, response);
            }
            
            
            /*GregorianCalendar gc = new GregorianCalendar (); //data odierna
            int mese = gc.get(Calendar.MONTH)+1;
            Date today = Date.valueOf (gc.get(Calendar.YEAR)+"-"+mese+"-"+gc.get(Calendar.DAY_OF_MONTH));*/
            
            System.out.println("DettaglioPazienteDottore: inizio caricamento...");
            
            //SCHEDA ANAGRAFICA ================================================
            try{
                paziente = pazienteDao.getById(pazienteId);
            }catch(NotFoundDAOException ex){
                daoFactory.closeConn();
                request.getRequestDispatcher("/WEB-INF/pagine/err404.jsp").forward(request, response);
            }
            request.setAttribute("paziente", paziente);
                 
            boolean ok = false;
            try {
                User user = (User) session.getAttribute("user");
                Dottore dottore = dottoreDao.getById(user.getId());
                
                if(dottore.getType() == TypeDoctor.P)
                {
                    if(user.getId() != paziente.getFamilydoctor())
                        throw new Exception(paziente.getFamilydoctor() +" != "+ user.getId());
                }
                ok = true;
            }
            catch(Exception e)
            {
                System.out.println(" -> accesso negato");
                daoFactory.closeConn();
                request.getRequestDispatcher("/WEB-INF/pagine/err403.jsp").forward(request, response);
            }
            
            if (ok) {


                try{
                    district = districtDao.getById(paziente.getDistrict());   
                }catch(NotFoundDAOException ex){
                    daoFactory.closeConn();
                    request.getRequestDispatcher("/WEB-INF/pagine/err404.jsp").forward(request, response);
                }          
                request.setAttribute("district", district);

                try{
                    familyDoctor = pazienteDao.getById(paziente.getFamilydoctor());
                }catch(NotFoundDAOException ex){
                    daoFactory.closeConn();
                    request.getRequestDispatcher("/WEB-INF/pagine/err404.jsp").forward(request, response);
                } 
                request.setAttribute("familyDoctor", familyDoctor);





                Visit ultimaVisita = null;
                try {
                    ultimaVisita = visitDao.getLastByPatient(pazienteId);

                }
                catch (Exception e) { }
                //System.out.println("ultima visita: " + ultimaVisita.getVisdate());
                request.setAttribute("ultimaVisita", ultimaVisita);

                // FOTO DEL PAZIENTE ===============================================
                List<Photo> photolist;
                photolist = photoDao.getByUser(paziente.getId());
                Photo ph = new Photo();
                if(photolist.isEmpty()) {
                    Timestamp timestamp = new Timestamp(System.currentTimeMillis());
                    ph.setTimestamp(timestamp);
                    ph.setUser(paziente.getId());
                    ph.setPath("/data/utente.png");
                    photolist.add(ph);
                }
                request.setAttribute("userpic", photolist);

                System.out.println("   fine caricamento dati pannello 1");

                //VISITE DAL MEDICO DI BASE ========================================
                List<Visit> visite = visitDao.getByPatient(pazienteId);
                HashMap<Integer, Paziente> mediciBase = new HashMap<>();
                for(Visit v : visite)
                    if(!mediciBase.containsKey(v.getFamilydoctor()))
                    {
                        Paziente n = pazienteDao.getById(v.getFamilydoctor());
                        mediciBase.put(n.getId(), n);
                    }
                request.setAttribute("visite", visite);
                request.setAttribute("mediciBase", mediciBase);

                System.out.println("   fine caricamento dati pannello 2");

                //RICETTE ==========================================================            
                try{
                    prescriptions = prescriptionDao.getPrescriptionChsByPatient(pazienteId);
                }catch(NotFoundDAOException ex){
                    daoFactory.closeConn();
                    request.getRequestDispatcher("/WEB-INF/pagine/err404.jsp").forward(request, response);
                }   
                request.setAttribute("prescriptions", prescriptions);

                System.out.println("   fine caricamento dati pannello 3");

                //ESAMI ============================================================
                try{
                    exams = examDao.getExamChsByPatient(pazienteId);
                }catch(NotFoundDAOException ex){
                    daoFactory.closeConn();
                    request.getRequestDispatcher("/WEB-INF/pagine/err404.jsp").forward(request, response);
                }               
                request.setAttribute("exams", exams);

                System.out.println("   fine caricamento dati pannello 4");

                //VISITE SPECIALISTICHE ============================================
                try{
                    speckvisits = speckvisitDao.getSpeckvisitChsByPatiente(pazienteId);
                }catch(NotFoundDAOException ex){
                    daoFactory.closeConn();
                    request.getRequestDispatcher("/WEB-INF/pagine/err404.jsp").forward(request, response);
                }              
                request.setAttribute("speckvisits", speckvisits);

                System.out.println("   fine caricamento dati pannello 5");

                daoFactory.closeConn();

                System.out.println(" -> DettaglioPaziente.jsp");

                request.getRequestDispatcher("/WEB-INF/pagine/dottore/DettaglioPaziente.jsp").forward(request, response);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (DaoException ex) {
            Logger.getLogger(DettaglioPaziente.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (DaoException ex) {
            Logger.getLogger(DettaglioPaziente.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

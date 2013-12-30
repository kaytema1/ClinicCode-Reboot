/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.*;
import java.net.*;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author StBuoy
 */
public class SyncClaims {

    static ExtendedHMSHelper mgr = new ExtendedHMSHelper();
    static List pendingClaims;
    static List diagnoses;;
    static List treatments;
    static List investigations;
   // static ArrayList<Total> totals;
    static BufferedReader reader = null;
    static String notes;

    public static void main(String[] args) throws Exception {
        sendData();
        //System.out.println(generateClaimID("meeagain"));
    }

    public static void saveNewNotes(String notesString) {
        String badges[] = notesString.split("-badge-");

        if (badges.length > 0) {
            String notes[] = badges[0].split("-new-");
            if (notes.length > 0) {
                for (int i = 1; i < notes.length; i++) {
                    String note[] = notes[i].split("-next-");
              
                    mgr.updateClaimNote(Integer.parseInt(note[2]),note[1]);
                }
            }
            if (badges[1].length() > 0) {
                String rejected[] = badges[1].split("-new-");
                if (rejected.length > 0) {
                    for (int i = 0; i < rejected.length; i++) {
                        mgr.updateClaimReturnStatus(Integer.parseInt(rejected[i]),"Rejected");
                    }
                }
            }
            if (badges[2].length() > 0) {
                String approved[] = badges[2].split("-new-");
                if (approved.length > 0) {
                    for (int i = 0; i < approved.length; i++) {
                        mgr.updateClaimReturnStatus(Integer.parseInt(approved[i]),"Approved");
                    }
                }
            }
            if (badges[3].length() > 0) {
                String totals[] = badges[3].split("-new-");
                if (totals.length > 0) {
                    for (int i = 0; i < totals.length; i++) {
                        String tosave[] = totals[i].split("-next-");
                        mgr.updateClaim(Integer.parseInt(tosave[0]),Double.parseDouble(tosave[1]));
                    }
                }
            }
        }
    }

    public static void sendData() {
        URL url = null;
        try {
            url = new URL("http://www.claimsync.com/socket_server.php");
            URLConnection conn = null;
            conn = url.openConnection();
            String claimdetails = "";
            String diagnosisdetails = "";
            String investigationdetails = "";
            String treatmentdetails = "";
            conn.setDoOutput(true);
            OutputStreamWriter writer = null;
            writer = new OutputStreamWriter(conn.getOutputStream());
            pendingClaims = mgr.listClaimsWhereStatus("Pending");
            for(int i=0;i<pendingClaims.size();i++){
                Claimtable claimtable = (Claimtable)pendingClaims.get(i);
                //claimdetails = 
                claimdetails = claimdetails + "-new-" + mgr.claimToString(claimtable);
                diagnoses = mgr.patientDiagnosis(claimtable.getVisitid());
                for (int r=0;r<diagnoses.size();r++) {
                    Patientdiagnosis patientdiagnosis = (Patientdiagnosis)diagnoses.get(r);
                    diagnosisdetails += "-new-" + mgr.diagnosisToString(patientdiagnosis, claimtable.getClaimid());
                    // System.out.println(dg.toString());
                }
                investigations = mgr.patientInvestigation(claimtable.getVisitid());
                for (int z=0;z<investigations.size();z++) {
                    Patientinvestigation patientinvestigation = (Patientinvestigation)investigations.get(z);
                    investigationdetails += "-new-" + mgr.investigationToString(patientinvestigation, claimtable.getTableid());
                    // System.out.println(investigationdetails);
                }
                treatments = mgr.listPatientTreatmentsByVisitId(claimtable.getVisitid());
                for (int s=0;s<treatments.size();s++) {
                    Patienttreatment patienttreatment = (Patienttreatment)treatments.get(s);
                    treatmentdetails += "-new-" + mgr.treatmentToString(patienttreatment, claimtable.getTableid());
                }
                mgr.updateClaimStatus(claimtable.getClaimid(), "Sent");
            }
            diagnosisdetails = diagnosisdetails.replace(" & ", "<>");
            // investigationdetails = investigationdetails.replace(" , ", "|");

            writer.write("claims=" + claimdetails + "&diagnosis=" + diagnosisdetails + "&treatment=" + treatmentdetails + "&investigation=" + investigationdetails);
            writer.flush();
            String line;
            reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            while ((line = reader.readLine()) != null) {
                notes = line;
                saveNewNotes(notes);
                System.out.println(notes);
            }
            writer.close();
            reader.close();
        } catch (IOException ex) {
            Logger.getLogger(SyncClaims.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
}
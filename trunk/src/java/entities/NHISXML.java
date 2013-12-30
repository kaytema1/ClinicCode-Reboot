/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

/**
 *
 * @author drac852002
 */
import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class NHISXML {

//public class WriteXMLFile {
    public static void main(String argv[]) {
        createXmlFile();
     //Patientdiagnosis patientdiagnosis = 
        HMSHelper hMSHelper = new HMSHelper();  
        System.out.println(hMSHelper.getDiagnosis(30).toString());
    }

    public static void createXmlFile() {
        try {

            DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = docFactory.newDocumentBuilder();

            // root elements
            Document doc = docBuilder.newDocument();
            Element rootElement = doc.createElement("Batch");
            doc.appendChild(rootElement);

            // Geenaral Information Elements
            Element generalInfo = doc.createElement("GeneralInformation");

            /*
             * Version Info Elements
             */
            Element versionInfo = doc.createElement("VersionInformation");
            Element xmlformat = doc.createElement("XMLFormatVersion");
            Element medicineVersion = doc.createElement("MedicineVersion");
            Element tariffVersion = doc.createElement("TariffVersion");
            Element ICDversion = doc.createElement("ICDVersion");
            Element openHdd = doc.createElement("OpenHDDVersion");
            versionInfo.appendChild(xmlformat);
            xmlformat.appendChild(doc.createTextNode("1"));
            versionInfo.appendChild(medicineVersion);
            medicineVersion.appendChild(doc.createTextNode("1"));
            versionInfo.appendChild(tariffVersion);
            tariffVersion.appendChild(doc.createTextNode("1"));
            versionInfo.appendChild(ICDversion);
            ICDversion.appendChild(doc.createTextNode("10"));
            versionInfo.appendChild(openHdd);
            openHdd.appendChild(doc.createTextNode("1"));
            /*
             * Batch Information Elements
             */
            Element batchInfo = doc.createElement("BatchInformation");
            Element batchNumber = doc.createElement("BatchNumber");
            Element batchAmount = doc.createElement("BatchAmount");
            Element batchCurrency = doc.createElement("BatchCurrency");
            Element claimsCount = doc.createElement("ClaimsCount");
            Element creationDate = doc.createElement("CreationDate");
            Element serviceYear = doc.createElement("ServiceYear");
            Element serviceMonth = doc.createElement("ServiceMonth");
            batchInfo.appendChild(batchNumber);
            batchNumber.appendChild(doc.createTextNode("00000001"));
            batchInfo.appendChild(batchAmount);
            batchAmount.appendChild(doc.createTextNode("11.78"));
            batchInfo.appendChild(batchCurrency);
            batchCurrency.appendChild(doc.createTextNode("GHC"));
            batchInfo.appendChild(claimsCount);
            claimsCount.appendChild(doc.createTextNode("3"));
            batchInfo.appendChild(creationDate);
            DateFormat date = new SimpleDateFormat("yyyy-MM-dd");
            creationDate.appendChild(doc.createTextNode(date.format(new Date())));
            batchInfo.appendChild(serviceYear);
            DateFormat year = new SimpleDateFormat("yyyy");
            serviceYear.appendChild(doc.createTextNode(year.format(new Date())));
            batchInfo.appendChild(serviceMonth);
            DateFormat month = new SimpleDateFormat("MM");
            serviceMonth.appendChild(doc.createTextNode(month.format(new Date())));
            /*
             * Provider Information Elements
             */
            Element providerInfo = doc.createElement("ProviderInformation");
            Element providerAccNum = doc.createElement("ProviderAccreditationNumber");
            Element eclaimAuth = doc.createElement("eClaimAuthorizationNumber");
            providerInfo.appendChild(providerAccNum);
            providerAccNum.appendChild(doc.createTextNode("HP0001"));
            providerInfo.appendChild(eclaimAuth);
            eclaimAuth.appendChild(doc.createTextNode("EHP0001"));
            /*
             * Patient Data Details
             * initial Data
             */
            Element patientDatas = doc.createElement("PatientDatas");
            Element patientData = doc.createElement("PatientData");

            Element claimid = doc.createElement("ClaimIdentificationNumber");
            claimid.appendChild(doc.createTextNode("00000000001"));

            Element surname = doc.createElement("Surname");
            surname.appendChild(doc.createTextNode("ATTAH"));

            Element othername = doc.createElement("OtherName");
            othername.appendChild(doc.createTextNode("FAUSTINA"));

            Element dob = doc.createElement("DateOfBirth");
            dob.appendChild(doc.createTextNode("25/08/1985"));

            Element hospitalId = doc.createElement("HospitalRecordNumber");
            hospitalId.appendChild(doc.createTextNode("12DC23"));

            Element membernumber = doc.createElement("MemberNumber");
            membernumber.appendChild(doc.createTextNode("5635715"));

            Element serialNumber = doc.createElement("CardSerialNumber");
            //outcomeType.appendChild(doc.createTextNode("DIS"));

            Element gender = doc.createElement("Gender");
            gender.appendChild(doc.createTextNode("F"));

            patientData.appendChild(surname);
            patientData.appendChild(othername);
            patientData.appendChild(dob);
            patientData.appendChild(membernumber);
            patientData.appendChild(hospitalId);
            patientData.appendChild(serialNumber);
            patientData.appendChild(gender);

            /*
             * Claims Elements
             */
            Element claims = doc.createElement("Claims");
            Element claim = doc.createElement("Claim");

            Element serviceType = doc.createElement("ServiceType");
            serviceType.appendChild(doc.createTextNode("OUT"));

            Element pharmacyIncluded = doc.createElement("PharmacyIncluded");
            pharmacyIncluded.appendChild(doc.createTextNode("YES"));

            Element allInclusive = doc.createElement("AllInclusive");
            allInclusive.appendChild(doc.createTextNode("YES"));

            Element outcomeType = doc.createElement("OutcomeType");
            outcomeType.appendChild(doc.createTextNode("DIS"));

            Element duration = doc.createElement("DurationLength");
            duration.appendChild(doc.createTextNode("1"));

            Element admissionType = doc.createElement("AdmissionType");
            admissionType.appendChild(doc.createTextNode("EME"));

            Element specialityCode = doc.createElement("SpecialityCode");
            specialityCode.appendChild(doc.createTextNode("ORTH"));

            Element dischargeDate = doc.createElement("DischargeDate");
            //dischargeDate.appendChild(doc.createTextNode("00000000001"));

            Element admissionDate = doc.createElement("AdmissionDate");
            admissionDate.appendChild(doc.createTextNode("11/05/2012"));

            Element outpatientTariff = doc.createElement("OutPatientTariffAmount");
            outpatientTariff.appendChild(doc.createTextNode("14.4"));

            Element totalCost = doc.createElement("TotalCost");
            totalCost.appendChild(doc.createTextNode("14.88"));

            Element treatmentCount = doc.createElement("TreatmentCount");
            treatmentCount.appendChild(doc.createTextNode("2"));

            Element medicineCount = doc.createElement("MedicineCount");
            medicineCount.appendChild(doc.createTextNode("2"));

            claim.appendChild(claimid);
            claim.appendChild(serviceType);
            claim.appendChild(pharmacyIncluded);
            claim.appendChild(allInclusive);
            claim.appendChild(outcomeType);
            claim.appendChild(duration);
            claim.appendChild(admissionType);
            claim.appendChild(specialityCode);
            claim.appendChild(admissionDate);
            claim.appendChild(outpatientTariff);
            claim.appendChild(totalCost);
            claim.appendChild(treatmentCount);
            claim.appendChild(medicineCount);
            //claim.appendChild(admissionType);
            /*
             * Treatment Elements
             */
            Element treatments = doc.createElement("Treatments");
            Element treatment = doc.createElement("Treatment");

            Element treatmentDate = doc.createElement("Date");
            treatmentDate.appendChild(doc.createTextNode("11/05/2012"));

            Element treatmentType = doc.createElement("Type");
            treatmentType.appendChild(doc.createTextNode("Diagnosis"));

            Element treatmentCode = doc.createElement("TreatmentCode");
            treatmentCode.appendChild(doc.createTextNode("ORTHEC06C"));

            Element icd10 = doc.createElement("ICDCode");
            icd10.appendChild(doc.createTextNode("T14.1"));

            Element tariff = doc.createElement("Tariff");
            tariff.appendChild(doc.createTextNode("4.04"));

            treatment.appendChild(treatmentDate);
            treatment.appendChild(treatmentType);
            treatment.appendChild(treatmentCode);
            treatment.appendChild(icd10);
            treatment.appendChild(tariff);
            /*
             * Medicine Elements
             */
            Element medicines = doc.createElement("Medicines");
            Element medicine = doc.createElement("Medicine");

            Element medicineCode = doc.createElement("MedicineCode");
            medicineCode.appendChild(doc.createTextNode("AMOXICCA1"));

            Element quantity = doc.createElement("Quantity");
            quantity.appendChild(doc.createTextNode("15"));

            Element unitPrice = doc.createElement("UnitPrice");
            unitPrice.appendChild(doc.createTextNode("0.05"));

            Element medicineTotal = doc.createElement("MedicineTotal");
            medicineTotal.appendChild(doc.createTextNode("0.75"));

            medicine.appendChild(medicineCode);
            medicine.appendChild(quantity);
            medicine.appendChild(unitPrice);
            medicine.appendChild(medicineTotal);
            /*
             * Investigation Elements
             */
            Element investigations = doc.createElement("Investigations");
            Element investigation = doc.createElement("investigation");

            Element investigationDate = doc.createElement("InvestigationDate");
            investigationDate.appendChild(doc.createTextNode("11/02/2012"));

            Element unitAmount = doc.createElement("UnitPrice");
            unitAmount.appendChild(doc.createTextNode("10.8"));

            Element icd = doc.createElement("ICDCode");
            icd.appendChild(doc.createTextNode("inv83.2"));

            Element investigationCode = doc.createElement("InvestigationCode");
            investigationCode.appendChild(doc.createTextNode("INVES01"));

            Element investigatioTotal = doc.createElement("InvestigationTotal");
            investigatioTotal.appendChild(doc.createTextNode("10.8"));

            investigation.appendChild(investigationDate);
            investigation.appendChild(investigationCode);
            investigation.appendChild(unitAmount);
            investigation.appendChild(icd);
            investigation.appendChild(investigatioTotal);
            /*Element creationDate = doc.createElement("CreationDate");
             Element serviceYear = doc.createElement("ServiceYear");
             Element serviceMonth = doc.createElement("ServiceMonth");*/

            rootElement.appendChild(generalInfo);
            generalInfo.appendChild(versionInfo);
            generalInfo.appendChild(batchInfo);
            generalInfo.appendChild(providerInfo);
            rootElement.appendChild(patientDatas);
            patientDatas.appendChild(patientData);
            patientData.appendChild(claims);
            claims.appendChild(claim);
            claim.appendChild(treatments);
            treatments.appendChild(treatment);
            claim.appendChild(medicines);
            medicines.appendChild(medicine);
            investigations.appendChild(investigation);


            // write the content into xml file
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(new File("web/claims/" + new Date() + "_file.xml"));
//result.
            // Output to console for testing
            // StreamResult result = new StreamResult(System.out);

            transformer.transform(source, result);

            //System.out.println("File saved!");
         

        } catch (ParserConfigurationException pce) {
        } catch (TransformerException tfe) {
        }
        //return null;
    }
//} 
}
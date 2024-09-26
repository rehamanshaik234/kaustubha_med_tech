import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class Constants{
  static String canceled = 'canceled';
  static String notConfirm = 'not-confirm';
  static String confirmed = 'confirmed';
  static String completed = 'completed';

  static RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  );

  static bool isNumeric(String str) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(str);
  }

  static String patientRole='USER';


  static String dateConverted(String date){
    final converted=DateFormat('d MMM y').format(DateTime.parse(date));
    return converted;
  }

  static String dateConvertedTransaction(String date){
    final converted=DateFormat('d MMM').format(DateTime.parse(date));
    return converted;
  }

  static String timeConverted(String date) {
    final dateTime = DateTime.parse(date);
    final formattedTime = DateFormat('h:mm a').format(dateTime);  // e.g., 3:01 PM
    return formattedTime;
  }

  static String convertDateForEnrollment(String inputDate){
    if(!inputDate.contains('/')) {
      DateTime dateTime = DateTime.parse(inputDate);
      String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
      return formattedDate;
    }else{
      return inputDate;
    }
  }

  static String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }


  static List<String> weeks=['Mon','Tue',"Wed","Thu","Fri","Sat","Sun"];

  static List<String>  languages=['English','Hindi',"Telugu","Tamil","Marathi","Kannada","Other"];

  ///Doctor Timings
  static List<String> timings=["08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00"];





  static final List<String> specialisations = [
    "Obstetrics",
    "Gynecology",
    "Maternal-Fetal Medicine",
    "Geriatrics",
    "Psychiatry",
    "Endocrinology"
  ];

  static final List<String> experiences = [
    "3",
    "5",
    "8",
    "10",
    "12",
    "14",
    "16",
    "18",
    "20",
  ];

  static final List<String> qualifications = [
    "MBBS",       // Bachelor of Medicine, Bachelor of Surgery
    "MD",         // Doctor of Medicine
    "DO",         // Doctor of Osteopathic Medicine
    "DM",         // Doctorate of Medicine (super-specialty)
    "MCh",        // Master of Chirurgiae (super-specialty surgery)
    "BDS",        // Bachelor of Dental Surgery
    "BPT",        // Bachelor of Physiotherapy
    "DNB",        // Diplomate of National Board (post-graduate)
    "MS",         // Master of Surgery
    "FRCS",       // Fellow of the Royal College of Surgeons
    "MRCP",       // Membership of the Royal Colleges of Physicians
    "MRCGP",      // Membership of the Royal College of General Practitioners
    "PhD",        // Doctor of Philosophy
    "MPH",        // Master of Public Health
    "MSc",        // Master of Science (in relevant medical field)
    "BPharm",     // Bachelor of Pharmacy
    "DPharm",     // Doctor of Pharmacy
    "BSN",        // Bachelor of Science in Nursing
    "MD-PhD",     // Combined Doctor of Medicine and Doctor of Philosophy
    "PGD",        // Post Graduate Diploma (various medical specializations)
  ];

  static Future<File?> compressFile(File file, {int quality = 50}) async {
    try {
      // Get file extension
      String extension = file.path.split('.').last.toLowerCase();

      if (extension == 'pdf') {
        // Compress PDF file
        return await compressPdf(file);
      } else if (['jpg', 'jpeg', 'png'].contains(extension)) {
        // Compress Image file
        return await compressImage(file, quality: quality);
      } else {
        // If the file type is unsupported, just return the original file
        print('Unsupported file type for compression');
        return file;
      }
    } catch (e) {
      print('Error compressing file: $e');
      return null;
    }
  }

  static Future<File?> compressPdf(File pdfFile) async {
    try {
      // Read the original PDF file as bytes
      List<int> pdfBytes = await pdfFile.readAsBytes();

      // Load the PDF document
      PdfDocument document = PdfDocument(inputBytes: pdfBytes);

      // Compress the PDF document
      document.compressionLevel = PdfCompressionLevel.best;

      // Save the compressed PDF to bytes
      List<int> compressedBytes = document.saveSync();

      // Create a new file path for the compressed PDF
      String compressedFilePath = '${pdfFile.path}_compressed.pdf';
      File compressedFile = File(compressedFilePath);

      // Write the compressed PDF bytes to the new file
      await compressedFile.writeAsBytes(compressedBytes);

      // Dispose of the document after saving
      document.dispose();

      return compressedFile;
    } catch (e) {
      print('Error compressing PDF: $e');
      return null;
    }
  }

  static Future<File?> compressImage(File imageFile, {int quality = 50}) async {
    try {
      // Read the image file as bytes
      Uint8List imageBytes = await imageFile.readAsBytes();

      // Decode the image using the `image` package
      img.Image? decodedImage = img.decodeImage(imageBytes);

      if (decodedImage != null) {
        // Compress the image to the desired quality
        Uint8List compressedBytes = Uint8List.fromList(img.encodeJpg(decodedImage, quality: quality));

        // Create a temporary file for the compressed image
        String compressedFilePath = '${imageFile.path}_compressed.jpg';
        File compressedImageFile = await File(compressedFilePath).writeAsBytes(compressedBytes);

        return compressedImageFile; // Return the compressed image file
      }
    } catch (e) {
      print('Error during image compression: $e');
    }
    return null; // Return null if compression fails
  }
}
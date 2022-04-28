/**************************************************************
 Project:  A template for saving a frame and the project code
 Date:     April 27, 2022
 
 About:    When working on sketches that use a lot of tinkering 
           and/or changing of settings it can be difficult to 
           recall the exacting settings for a desired output.
           If a desired output is being created a file saving
           the desired frame as a png and a text file 
           copying the code from the project file will be
           created with the same filename. They can be matched
           in the future in order to recreate the desired
           output. 
 
 Notes:
 - Processing 3.5.4
 - After running sketch and a desired output is seen
 - SAVE PROJECT. If current state is not saved the last
   saved project code will be written to file!
 - Run sketch again and press the 'S' key at desired frame
 - The following files will be created in the sketch folder:
     output_images
     output_files
 - An image and text file will be saved in the corresponding
   file with the same name in the format:
     yyyy-mm-ddTHHmmss
 - For projects with tabs. Place saveSketchState() function in 
   the main sketch tab. Additional classes will be placed in
   alphabetical order below the code from the main sketch file. 
 - The console will print out the saving process along with an
   absolute path should it be necessary. 
   
 TO DO:
 - It would be great to be able to save a copy of current code
   regardless of saving the project. Unsure if there is a way
   to access the code sent to compiler. 
 **************************************************************/

/**************************************************************
 SET UP FUNCTION
 **************************************************************/
void setup() {
  
  size(600, 600);
  
}

/**************************************************************
 DRAW FUNCTION
 **************************************************************/
void draw() {
  background(0);
  
  fill(random(255), random(255), random(255));
  ellipse(random(width), random(height), 100, 100);  
}

/**************************************************************
 KEY PRESSED
 
 - 'S' KEY | save frame and code
 **************************************************************/
void keyPressed() {
  if(key == 's' || key == 'S') {
    saveSketchState();
  }
  
}

/*
 * Function for saving the frame as a png when called along with
 * a text file containing the project code. Files that have .pde
 * extension will be saved. 
 *
 */
void saveSketchState() { 
  // get basic sketch info
  String sketchName = getClass().getName();
  String sketchFile = sketchName + ".pde";
  
  print(sketchName + " :saving sketch code... ");
  
   // create file name in yyyy-mm-ddTHHmmss
  int y = year();
  int m = month();
  int d = day();
  int h = hour();
  int min = minute();
  int s = second();    
  String saveFileName = y + "-" + nf(m, 2) + "-" + nf(d, 2) + "T";
         saveFileName += nf(h, 2) + nf(min, 2) + nf(s, 2);
                  
  // create file
  PrintWriter saveCodeWriter = createWriter("output_files/" + saveFileName + ".txt");
  
  // save main class to file
  String[] codeLines = loadStrings(sketchFile);    
  for (int i = 0 ; i < codeLines.length; i++) {
    saveCodeWriter.println(codeLines[i]);
  }
     
  // save additional classes to file
  File folder = new File(this.sketchPath());
  File[] files = folder.listFiles();
  if(files.length > 0) {
    for(File file : files) {
      String filename = file.getName();
      if(filename.endsWith(".pde") && !filename.equals(sketchFile)) {
        codeLines = null;
        codeLines = loadStrings(filename);
        for (int i = 0 ; i < codeLines.length; i++) {
          saveCodeWriter.println(codeLines[i]);
        }
      }
    }
  }
  
  // close writer and file
  saveCodeWriter.flush();
  saveCodeWriter.close();
  
  // save frame as image
  print("saving frame...");
  saveFrame("output_images/" + saveFileName + ".png");  
  
  print("done!\n");
  println(sketchPath());
}

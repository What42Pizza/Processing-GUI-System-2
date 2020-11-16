// Started 10/05/20
// Last updated 11/16/20



// Everything in here is just an example of how to use this (but it's also just testing)



GUI_Functions GUIFunctions = new GUI_Functions(); // YOU NEED TO HAVE THIS AT THE START OF YOUR PROGRAM FOR THIS TO WORK

void keyPressed() {
  GUIFunctions.keyPressed();
  if (key == 27) key = 0;
}

void mouseWheel (MouseEvent E) {
  GUIFunctions.mouseWheel(E);
}










GUI_Element AllFrames = new GUI_Element (new String[] { // This holds all other frames so they can be rendered with one line of code
  "ElementType:", "Frame",
  "Name:" , "AllFrames",
  "XPos:" , "0",
  "YPos:" , "0",
  "XSize:", "1",
  "YSize:", "1",
  "EdgeSize:", "0",
  "BackgroundColor:", "007F7F7F", // Gray; alpha at 0 (completely transparent)
  "Visible:", "false",
});





GUI_Element NestedFrame1 = new GUI_Element (new String[] {
  "ElementType:", "TextFrame",
  "Name:" , "NestedFrame1",
  "XPos:" , "0.25",
  "YPos:" , "0.25",
  "XSize:", "0.5" ,
  "YSize:", "0.5" ,
  "Draggable:", "true",
  "Text:", "Drag me!",
  "TextAlignY:", "-1",
  "TextSize:", "0.5",
});

GUI_Element NestedFrame2 = new GUI_Element (new String[] {
  "ElementType:", "Frame",
  "Name:" , "NestedFrame2",
  "XPos:" , "0.25",
  "YPos:" , "0.25",
  "XSize:", "0.5" ,
  "YSize:", "0.5" ,
});

GUI_Element NestedFrame3 = new GUI_Element (new String[] {
  "ElementType:", "Frame",
  "Name:" , "NestedFrame3",
  "XPos:" , "0.25",
  "YPos:" , "0.25",
  "XSize:", "0.5" ,
  "YSize:", "0.5" ,
});

GUI_Element NestedFrame4 = new GUI_Element (new String[] {
  "ElementType:", "Frame",
  "Name:" , "NestedFrame4",
  "XPos:" , "0.25",
  "YPos:" , "0.25",
  "XSize:", "0.5" ,
  "YSize:", "0.5" ,
});

GUI_Element NestedFrame5 = new GUI_Element (new String[] {
  "ElementType:", "Frame",
  "Name:" , "NestedFrame5",
  "XPos:" , "0.25",
  "YPos:" , "0.25",
  "XSize:", "0.5" ,
  "YSize:", "0.5" ,
});





GUI_Element GlowingFrame = new GUI_Element (new String[] {
  "ElementType:", "TextFrame",
  "Name:", "GlowingFrame1",
  "XPos:" , "0.1 ",
  "YPos:" , "0.11",
  "XSize:", "0.1" ,
  "YSize:", "0.1" ,
  "Text:" , "Hover over me!",
});





GUI_Element VisibleFrame = new GUI_Element (new String[] {
  "ElementType:", "TextFrame",
  "Name:", "VisibleFrame",
  "XPos:" , "0.1 ",
  "YPos:" , "0.22",
  "XSize:", "0.1" ,
  "YSize:", "0.1" ,
  "Text:" , "Visible",
  "TextSize:", "0.4",
  "TextAlignY:", "-1",
});

GUI_Element NestedVisibleFrame = new GUI_Element ("Frame", "NestedVisibleFrame");





GUI_Element EnableFrame = new GUI_Element (new String[] {
  "ElementType:", "TextFrame",
  "Name:" , "EnableFrame",
  "XPos:" , "0.1 ",
  "YPos:" , "0.33",
  "XSize:", "0.1" ,
  "YSize:", "0.1" ,
  "Text:" , "Enable",
  "TextSize:", "0.4",
  "TextAlignY:", "-1",
});

GUI_Element NestedEnableFrame = new GUI_Element ("Frame", "NestedEnableFrame");





GUI_Element ButtonFrame = new GUI_Element (new String[] {
  "ElementType:", "TextButton",
  "Name:" , "ButtonFrame",
  "XPos:" , "0.1" ,
  "YPos:" , "0.44",
  "XSize:", "0.1" ,
  "YSize:", "0.1" ,
  "Text:" , "Click me!",
});





GUI_Element LoadedFrame;





GUI_Element TextBox = new GUI_Element (new String[] {
  "ElementType:", "TextBox",
  "Name:" , "TextBox",
  "Text:", "Click this to edit the text!",
  "XPos:" , "0.1" ,
  "YPos:" , "0.66",
  "XSize:", "0.1 ",
  "YSize:", "0.1 ",
});





GUI_Element ImageButtonFrame = new GUI_Element (new String[] {
  "ElementType:", "ImageButton",
  "Name:" , "ImageButtonFrame",
  "XPos:" , "0.1" ,
  "YPos:" , "0.77",
  "XSize:", "0.1" ,
  "YSize:", 16.0 / 9.0 * 0.1 + " ",
});





GUI_Element ExitButton = new GUI_Element (new String[] {
  "ElementType:", "TextButton",
  "Name:", "ExitButton",
  "XPos:" , "0.84",
  "YPos:" , "0.02",
  "XSize:", "0.15",
  "YSize:", "0.15",
  "Text:", "Exit",
  "TextSize:", "0.75",
});





GUI_Element ScrollingFrame = new GUI_Element (new String[] {
  "ElementType:", "ScrollingFrame",
  "Name:", "ScrollingFrame",
  "XPos:" , "0.21",
  "YPos:" , "0.11",
  "XSize:", "0.03",
  "YSize:", "0.8",
  "BackgroundColor:", "BF", // color (191)
  //"RenderChildrenNotInFrame:", "false",
});

GUI_Element ScrollingFrameChild = new GUI_Element (new String[] {
  "ElementTpye:", "Frame",
  "Name:", "ScrollingFrameChild",
  "XPos:" , "0",
  "YPos:" , "0",
  "XSize:", "1",
  "YSize:", "0.2",
});










void setup() {
  
  
  
  fullScreen();
  frameRate (60);
  
  
  
  AllFrames.AddChild (GlowingFrame);
  
  AllFrames.AddChild (VisibleFrame);
    VisibleFrame.AddChild (NestedVisibleFrame);
    
  AllFrames.AddChild (EnableFrame);
    EnableFrame.AddChild (NestedEnableFrame);
    
  AllFrames.AddChild (ButtonFrame);
  
  AllFrames.AddChild (TextBox);
  
  AllFrames.AddChild (ImageButtonFrame);
  
  AllFrames.AddChild (ExitButton);
  
  AllFrames.AddChild (ScrollingFrame);
    ScrollingFrame.AddChild (ScrollingFrameChild);
  
  AllFrames.AddChild (NestedFrame1);
    NestedFrame1.AddChild (NestedFrame2);
      NestedFrame2.AddChild (NestedFrame3);
        NestedFrame3.AddChild (NestedFrame4);
          NestedFrame4.AddChild (NestedFrame5);
  
  thread ("LoadFrames");
  
  
  
  println ("All descendants for AllFrames:");
  ArrayList <GUI_Element> Children = AllFrames.AllDescendants();
  for (GUI_Element E : Children) {
    for (int i = 0; i < E.FamilyLevel; i ++) {print ("  ");}
    println (E);
  }
  
  println();
  
  println ("All ancestors for NestedFrame5:");
  ArrayList <GUI_Element> Ancestors = NestedFrame5.AllAncestors();
  for (GUI_Element E : Ancestors) {
    for (int i = 0; i < E.FamilyLevel; i ++) {print ("  ");}
    println (E);
  }
  
  println();
  
  println ("Results for NestedFrame3: " + NestedFrame1.Descendant("NestedFrame3"));
  println ("Results for NestedFrame6: " + NestedFrame1.Descendant("NestedFrame6"));
  
  println();
  
  println ("Results for NestedFrame2: " + NestedFrame4.Ancestor("NestedFrame2"));
  println ("Results for NestedFrame0: " + NestedFrame4.Ancestor("NestedFrame0"));
  
  
  
}





void LoadFrames() {
  
  String LoadedFrameFileName = dataPath("") + "/GUI/Child.LoadedFrame";
  File LoadedFrameFile = new File (LoadedFrameFileName);
  if (LoadedFrameFile.exists()) {
    AllFrames.AddChild (0, new GUI_Element (LoadedFrameFile));
  } else {
    println ("Error: Could not find the file " + '"' + LoadedFrameFileName + '"' + " for LoadedFrame.");
  }
  
  ImageButtonFrame.Image = loadImage ("https://processing.org/img/processing3-logo.png"); // Go to https://processing.org/img for a list of images
  if (ImageButtonFrame.Image != null)
    ImageButtonFrame.HasFrame = false;
  
}










void draw() {
  
  
  
  background (255);
  fill (0);
  textSize (15);
  textAlign (LEFT, BOTTOM);
  text (frameRate, 4, 25);
  
  
  
  NestedFrame2.XPos = NestedFrame1.XPos;
  NestedFrame2.YPos = NestedFrame1.YPos;
  
  NestedFrame3.XPos = NestedFrame1.XPos;
  NestedFrame3.YPos = NestedFrame1.YPos;
  
  NestedFrame4.XPos = NestedFrame1.XPos;
  NestedFrame4.YPos = NestedFrame1.YPos;
  
  NestedFrame5.XPos = NestedFrame1.XPos;
  NestedFrame5.YPos = NestedFrame1.YPos;
  
  
  
  if (GlowingFrame.HasMouseHovering()) {
    GlowingFrame.BackgroundColor = color (255);
  } else {
    GlowingFrame.BackgroundColor = color (127);
  }
  
  
  
  VisibleFrame.Visible = !VisibleFrame.HasMouseHovering(); // Make frame not visible when mouse is hovering
  EnableFrame .Enabled = !EnableFrame .HasMouseHovering(); // Make frame not enabled when mouse is hovering 
  
  
  
  if (ExitButton.JustClicked()) {
    exit();
  }
  
  
  
  AllFrames.Render(); // This renders all frames
  
  
  
}

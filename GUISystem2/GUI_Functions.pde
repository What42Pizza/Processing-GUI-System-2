// This holds general functions used in GUI elements





float CustMatrix_TranslateX = 0;
float CustMatrix_TranslateY = 0;
float CustMatrix_ScaleX = 1;
float CustMatrix_ScaleY = 1;

ArrayList <float[]> MatrixStack = new ArrayList <float[]> ();





void PushMatrix() {
  float[] CurrMatrix = new float[] {
    CustMatrix_TranslateX,
    CustMatrix_TranslateY,
    CustMatrix_ScaleX,
    CustMatrix_ScaleY
  };
  MatrixStack.add (CurrMatrix);
  if (MatrixStack.size() > 100) println ("WARNING: The matrix stack is becoming extremely large (size: " + MatrixStack.size() + "). You should consider simplifying your GUI.");
}



void PopMatrix() {
  float[] NewMatrix = MatrixStack.remove (MatrixStack.size() - 1);
  CustMatrix_TranslateX = NewMatrix[0];
  CustMatrix_TranslateY = NewMatrix[1];
  CustMatrix_ScaleX = NewMatrix[2];
  CustMatrix_ScaleY = NewMatrix[3];
}



void Translate (float XAmount, float YAmount) {
  CustMatrix_TranslateX += XAmount * CustMatrix_ScaleX;
  CustMatrix_TranslateY += YAmount * CustMatrix_ScaleY;
}



void Scale (float XAmount, float YAmount) {
  CustMatrix_ScaleX /= XAmount;
  CustMatrix_ScaleY /= YAmount;
}





/*
String ImageURLToLoad = "";
GUI_Element ElementToLoadImageFor;



void Threaded_LoadImage() { // I don't know if you could have multiple threads of this running but probably not
  PImage LoadedImage = null;
  
  try {
    LoadedImage = loadImage (ImageURLToLoad);
    
  } catch (Exception e) {
    println ("Error: Could not load image from " + '"' + ImageURLToLoad + '"' + ".");
    
  } finally {
    if (LoadedImage != null) {
      ElementToLoadImageFor.Image = LoadedImage;
    }
    
  }
}
*/










public class GUI_Functions {
  
  
  
  
  
  int LastUpdatedCount = 1; // >:(
  Character[] NewKeyPresses = new Character [0];
  ArrayList <Character> NewKeyPressesBuffer = new ArrayList <Character> ();
  
  
  
  public void keyPressed() {
    NewKeyPressesBuffer.add (key);
  }
  
  
  
  public Character[] GetNewKeyPresses() {
    
    if (LastUpdatedCount != frameCount) { // If this is a start of a new frame
      LastUpdatedCount = frameCount;
      NewKeyPresses = new Character [NewKeyPressesBuffer.size()];
      for (int i = 0; i < NewKeyPresses.length; i ++)
        NewKeyPresses[i] = NewKeyPressesBuffer.get(i);
      NewKeyPressesBuffer = new ArrayList <Character> ();
    }
    
    return NewKeyPresses;
    
  }
  
  
  
  public boolean KeyPressed (int Key) {
    for (Character C : NewKeyPresses) {
      if (C == Key)
        return true;
    }
    return false;
  }
  
  
  
  
  
  public void DrawRect (float XPos, float YPos, float XSize, float YSize, color BackgroundColor, int EdgeSize, color EdgeColor) {
    
    int ScreenXPos  = GetScreenX (XPos);
    int ScreenXEnd  = GetScreenX (XPos + XSize);
    int ScreenXSize = ScreenXEnd - ScreenXPos;
    int ScreenYPos  = GetScreenY (YPos);
    int ScreenYEnd  = GetScreenY (YPos + YSize);
    int ScreenYSize = ScreenYEnd - ScreenYPos;
    
    stroke (EdgeColor);
    strokeWeight (EdgeSize);
    fill (BackgroundColor);
    rect (ScreenXPos, ScreenYPos, ScreenXSize, ScreenYSize);
    
  }
  
  
  
  public void DrawText (String Text, float TextXPos, float TextYPos, color TextColor, float TextSize, String TextSizeIsRelativeTo, float XPos, float XSize) {
    
    switch (TextSizeIsRelativeTo) {
      case ("FRAME"):
        textSize (GetScreenXSize (XPos, XSize) * TextSize / 10);
        break;
      case ("SCREEN"):
        textSize (width * TextSize / 100);
        break;
      default:
        println ("Error: TextSizeIsRelativeTo cannot be " + '"' + TextSizeIsRelativeTo + '"' + ", it has to be either " + '"' + "FRAME" + '"' + " or " + '"' + "SCREEN" + '"' + ".");
        break;
    }
    
    fill (TextColor);
    text (Text, GetScreenX (TextXPos), GetScreenY (TextYPos));
    
  }
  
  
  
  public void DrawImage (PImage Image, float XPos, float YPos, float XSize, float YSize) {
    
    int ScreenXPos  = GetScreenX (XPos);
    int ScreenXEnd  = GetScreenX (XPos + XSize);
    int ScreenXSize = ScreenXEnd - ScreenXPos;
    int ScreenYPos  = GetScreenY (YPos);
    int ScreenYEnd  = GetScreenY (YPos + YSize);
    int ScreenYSize = ScreenYEnd - ScreenYPos;
    
    image (Image, ScreenXPos, ScreenYPos, ScreenXSize, ScreenYSize);
    
  }
  
  
  
  
  
  int[] TextAlignConversionX = new int[] {37 , 3, 39 };
  int[] TextAlignConversionY = new int[] {101, 3, 102};
  
  public void SetTextAlignment (int TextAlignX, int TextAlignY) {
    textAlign (TextAlignConversionX[TextAlignX+1], TextAlignConversionY[TextAlignY+1]);
  }
  
  
  
  
  
  public int GetScreenX (float XPos) {
    return (int)((XPos * CustMatrix_ScaleX + CustMatrix_TranslateX) * width);
  }
  
  public int GetScreenY (float YPos) {
    return (int)((YPos * CustMatrix_ScaleY + CustMatrix_TranslateY) * height);
  }
  
  public float GetFrameX (int ScreenX) {
    return (((float) ScreenX / width) - CustMatrix_TranslateX) / CustMatrix_ScaleX;
  }
  
  public float GetFrameY (int ScreenY) {
    return (((float) ScreenY / height) - CustMatrix_TranslateY) / CustMatrix_ScaleY;
  }
  
  
  
  public int GetScreenXSize (float XPos, float XSize) {
    return GetScreenX (XPos + XSize) - GetScreenX (XPos);
  }
  
  public int GetScreenYSize (float YPos, float YSize) {
    return GetScreenY (YPos + YSize) - GetScreenY (YPos);
  }
  
  
  
  
  
  
  
  
  
  
  public String GetSetting (String[] Settings, String SettingName) {
    SettingName += ':';
    for (int i = 0; i < Settings.length - 1; i ++) {
      String S = Settings[i];
      if (S.equals(SettingName)) {
        return Settings [i + 1];
      }
    }
    return null;
  }
  
  
  
  public String[] GetPropertiesFromFolder (File FolderIn) {
    
    if (FolderIn == null || !FolderIn.exists()) {
      println ("Error: The File given for constructing a GUI element cannot be null or non-existent.");
      return new String[]{};
    }
    
    if (!FolderIn.isDirectory()) {
      println ("Error: The File given for constructing a GUI element (" + FolderIn.getAbsolutePath() + ") cannot be file, it must be a folder.");
      return new String[]{};
    }
    
    File PropertiesFile = GetChildFile (FolderIn, "Properties.txt");
    
    if (PropertiesFile == null) {
      println ("Error: Could not find Properties.txt in " + FolderIn.getAbsolutePath() + " while constructing GUI element.");
      return new String[]{};
    }
    
    return loadStrings (PropertiesFile);
    
  }
  
  
  
  public File GetChildFile (File Folder, String ChildName) {
    File Output = null;
    for (File F : Folder.listFiles()) {
      if (F.getName().equals(ChildName)) {
        return F;
      }
    }
    return Output;
  }
  
  
  
  
  
  
  
  
  
  
  public void SetGUIElementProperties (GUI_Element Element, String[] Properties) {
    
    
    
    String ElementType = GetSetting (Properties, "ElementType");
    if (ElementType != null)
      Element.SetBasicType (ElementType);
    
    
    
    String Name = GetSetting (Properties, "Name");
    if (Name != null)
      Element.Name = Name;
    
    
    
    String HasFrame = GetSetting (Properties, "HasFrame");
    if (HasFrame != null)
      Element.HasFrame = boolean (HasFrame);
    
    String HasText = GetSetting (Properties, "HasText");
    if (HasText != null)
      Element.HasText = boolean (HasText);
    
    String HasImage = GetSetting (Properties, "HasImage");
    if (HasImage != null)
      Element.HasImage = boolean (HasImage);
    
    String CanBePressed = GetSetting (Properties, "CanBePressed");
    if (CanBePressed != null)
      Element.CanBePressed = boolean (CanBePressed);
    
    
    
    String XPos = GetSetting (Properties, "XPos");
    if (XPos != null)
      Element.XPos = float (XPos);
    
    String YPos = GetSetting (Properties, "YPos");
    if (YPos != null)
      Element.YPos = float (YPos);
    
    String XSize = GetSetting (Properties, "XSize");
    if (XSize != null)
      Element.XSize = float (XSize);
    
    String YSize = GetSetting (Properties, "YSize");
    if (YSize != null)
      Element.YSize = float (YSize);
    
    
    
    String BackgroundColor = GetSetting (Properties, "BackgroundColor");
    if (BackgroundColor != null)
      Element.BackgroundColor = unhex (BackgroundColor);
    
    String EdgeColor = GetSetting (Properties, "EdgeColor");
    if (EdgeColor != null)
      Element.EdgeColor = unhex (EdgeColor);
    
    String EdgeSize = GetSetting (Properties, "EdgeSize");
    if (EdgeSize != null)
      Element.EdgeSize = int (EdgeSize);
    
    
    
    String Draggable = GetSetting (Properties, "Draggable");
    if (Draggable != null)
      Element.Draggable = boolean (Draggable);
    
    String Visible = GetSetting (Properties, "Visible");
    if (Visible != null)
      Element.Visible = boolean (Visible);    
    
    String Enabled = GetSetting (Properties, "Enabled");
    if (Enabled != null)
      Element.Enabled = boolean (Enabled);
    
    String RenderChildrenNotInFrame = GetSetting (Properties, "RenderChildrenNotInFrame");
    if (RenderChildrenNotInFrame != null)
      Element.RenderChildrenNotInFrame = boolean (RenderChildrenNotInFrame);    
    
    String UpdateChildrenNotInFrame = GetSetting (Properties, "UpdateChildrenNotInFrame");
    if (UpdateChildrenNotInFrame != null)
      Element.UpdateChildrenNotInFrame = boolean (UpdateChildrenNotInFrame);
    
    
    
    String Text = GetSetting (Properties, "Text");
    if (Text != null)
      Element.Text = Text;
    
    String PlaceholderText = GetSetting (Properties, "PlaceholderText");
    if (PlaceholderText != null)
      Element.PlaceholderText = PlaceholderText;
    
    String UsePlaceholderText = GetSetting (Properties, "UsePlaceholderText");
    if (UsePlaceholderText != null)
      Element.UsePlaceholderText = boolean (UsePlaceholderText);
    
    String TextColor = GetSetting (Properties, "TextColor");
    if (TextColor != null)
      Element.TextColor = unhex (TextColor);
    
    String TextSize = GetSetting (Properties, "TextSize");
    if (TextSize != null)
      Element.TextSize = float (TextSize);
    
    String TextSizeIsRelativeTo = GetSetting (Properties, "TextSizeIsRelativeTo");
    if (TextSizeIsRelativeTo != null)
      Element.TextSizeIsRelativeTo = TextSizeIsRelativeTo;
    
    String TextAlignX = GetSetting (Properties, "TextAlignX");
    if (TextAlignX != null)
      Element.TextAlignX = int (TextAlignX);
    
    String TextAlignY = GetSetting (Properties, "TextAlignY");
    if (TextAlignY != null)
      Element.TextAlignY = int (TextAlignY);
    
    
    
    String TextIsEditable = GetSetting (Properties, "TextIsEditable");
    if (TextIsEditable != null)
      Element.TextIsEditable = boolean (TextIsEditable);
    
    String TextResetsOnEdit = GetSetting (Properties, "TextResetsOnEdit");
    if (TextResetsOnEdit != null)
      Element.TextResetsOnEdit = boolean (TextResetsOnEdit);
    
    
    
    String PressedBackgroundColor = GetSetting (Properties, "PressedBackgroundColor");
    if (PressedBackgroundColor != null)
      Element.PressedBackgroundColor = unhex (PressedBackgroundColor);
    
    String UsePressedColor = GetSetting (Properties, "UsePressedColor");
    if (UsePressedColor != null)
      Element.UsePressedColor = boolean (UsePressedColor);
    
    String XMove = GetSetting (Properties, "XMove");
    if (XMove != null)
      Element.PressedXMove = float (XMove);
    
    String YMove = GetSetting (Properties, "YMove");
    if (YMove != null)
      Element.PressedYMove = float (YMove);
    
    
    
    String ImageXSize = GetSetting (Properties, "ImageXSize");
    if (ImageXSize != null)
      Element.ImageXSize = float (ImageXSize);
    
    String ImageYSize = GetSetting (Properties, "ImageYSize");
    if (ImageYSize != null)
      Element.ImageYSize = float (ImageYSize);
    
    
    
  }
  
  
  
  
  
  
  
  
  
  
}

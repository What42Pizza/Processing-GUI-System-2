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










class Action {
  
  public void Run (GUI_Element ButtonElement) {
    println ("Error: ButtonAction for " + ButtonElement + " has not been set.");
  }
  
}










public class GUI_Functions {
  
  
  
  
  
  ArrayList <GUI_Element> AllGUIElements = new ArrayList <GUI_Element> ();
  
  
  
  boolean EscKeyUsed = false;
  
  
  
  
  
  
  
  
  
  
  int LastUpdatedCount_Keys = 1; // >:(
  Character[] NewKeyPresses = new Character [0];
  ArrayList <Character> NewKeyPressesBuffer = new ArrayList <Character> ();
  
  boolean[] Keys = new boolean [128];
  boolean[] PrevKeys = new boolean [128];
  
  
  
  public void keyPressed() {
    if (key < 128) Keys[key] = true;
    NewKeyPressesBuffer.add (key);
  }
  
  public void keyReleased() {
    if (key < 128) Keys[key] = false;
  }
  
  
  
  public Character[] GetNewKeyPresses() {
    
    if (LastUpdatedCount_Keys != frameCount) { // If this is a start of a new frame
      LastUpdatedCount_Keys = frameCount;
      NewKeyPresses = new Character [NewKeyPressesBuffer.size()];
      for (int i = 0; i < NewKeyPresses.length; i ++)
        NewKeyPresses[i] = NewKeyPressesBuffer.get(i);
      NewKeyPressesBuffer = new ArrayList <Character> ();
    }
    
    return NewKeyPresses;
    
  }
  
  
  
  public boolean KeyJustPressed (int Key) {
    for (Character C : NewKeyPresses) {
      if (C == Key) return true;
    }
    return false;
  }
  
  
  
  public boolean KeyIsPressed (int Key) {
    if (key < 128) return Keys[Key];
    return false;
  }
  
  
  
  
  
  int LastUpdatedCount_Scroll = 1;
  float ScrollAmount = 0;
  float ScrollAmountBuffer = 0;
  
  public void mouseWheel (MouseEvent E) {
    ScrollAmountBuffer += E.getCount();
  }
  
  
  
  public float GetScrollAmount() {
    
    if (LastUpdatedCount_Scroll != frameCount) {
      LastUpdatedCount_Scroll = frameCount;
      ScrollAmount = ScrollAmountBuffer;
      ScrollAmountBuffer = 0;
    }
    
    return ScrollAmount;
    
  }
  
  
  
  
  
  
  
  
  
  
  /*
  public void Rect (float XPos, float YPos, float XSize, float YSize) { // , color BackgroundColor, int EdgeSize, color EdgeColor) {
    
    int ScreenXPos  = GetScreenX (XPos);
    int ScreenXEnd  = GetScreenX (XPos + XSize);
    int ScreenXSize = ScreenXEnd - ScreenXPos;
    int ScreenYPos  = GetScreenY (YPos);
    int ScreenYEnd  = GetScreenY (YPos + YSize);
    int ScreenYSize = ScreenYEnd - ScreenYPos;
    
    /*
    stroke (EdgeColor);
    strokeWeight (EdgeSize);
    fill (BackgroundColor);
    */ /*
    
    rect (ScreenXPos, ScreenYPos, ScreenXSize, ScreenYSize);
    
  }
  */
  
  
  
  public void Text (String Text, float TextXPos, float TextYPos) { //, float TextSize, String TextSizeIsRelativeTo, float XPos, float XSize) {
    
    text (Text, GetScreenX (TextXPos), GetScreenY (TextYPos));
    
  }
  
  
  
  /*
  public void Image (PImage Image, float XPos, float YPos, float XSize, float YSize) {
    
    int ScreenXPos  = GetScreenX (XPos);
    int ScreenXEnd  = GetScreenX (XPos + XSize);
    int ScreenXSize = ScreenXEnd - ScreenXPos;
    int ScreenYPos  = GetScreenY (YPos);
    int ScreenYEnd  = GetScreenY (YPos + YSize);
    int ScreenYSize = ScreenYEnd - ScreenYPos;
    
    image (Image, ScreenXPos, ScreenYPos, ScreenXSize, ScreenYSize);
    
  }
  */
  
  
  
  
  
  
  
  
  
  
  int[] TextAlignConversionX = new int[] {37 , 3, 39 };
  int[] TextAlignConversionY = new int[] {101, 3, 102};
  
  
  
  public void SetTextAlign (int TextAlignX, int TextAlignY) {
    textAlign (TextAlignConversionX[TextAlignX+1], TextAlignConversionY[TextAlignY+1]);
  }
  
  
  
  public void SetTextSize (String TextToDisplay, float TextSize, String TextSizeIsRelativeTo, boolean TextSizeScales, int ScreenXSize, int ScreenYSize) {
    switch (TextSizeIsRelativeTo) {
      
      case ("FRAME"):
        if (TextSizeScales) {
          SetTextSize (TextToDisplay, ScreenXSize * TextSize, ScreenYSize);
        } else {
          textSize (ScreenXSize * TextSize / 10);
        }
        return;
      
      case ("SCREEN"):
        if (TextSizeScales) {
          SetTextSize (TextToDisplay, width * TextSize, ScreenYSize);
        } else {
          textSize (width * TextSize / 100);
        }
        return;
      
      default:
        println ("Error: TextSizeIsRelativeTo cannot be " + '"' + TextSizeIsRelativeTo + '"' + ", it has to be either " + '"' + "FRAME" + '"' + " or " + '"' + "SCREEN" + '"' + ".");
        return;
      
    }
  }
  
  
  
  public void SetTextSize (String TextToDisplay, float TextWidth, int MaxSize) {
    
    final float Scale = 100;
    textSize (Scale);
    float TextWidth100 = textWidth (TextToDisplay);
    
    textSize (min (MaxSize, TextWidth / (TextWidth100 / Scale))); // TextWidth100 / Scale gives what the width would be for textSize of 1 (lets just say this would be 20 pixels), so if you wanted it to be, lets say, 30 pixels, you would do 30 / 20 to give you the textSize of 1.5
    
  }
  
  
  
  public float[] GetAlignedPosition (float XPos, float YPos, float XSize, float YSize, int TextAlignX, int TextAlignY) {
    return new float[] {
      XPos + XSize / 2 * (TextAlignX + 1),
      YPos + YSize / 2 * (TextAlignY + 1)
    };
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
  
  
  
  public File GetChildFile (File Folder, String ChildName) {
    File Output = null;
    for (File F : Folder.listFiles()) {
      if (F.getName().equals(ChildName)) {
        return F;
      }
    }
    return Output;
  }
  
  
  
  
  
  
  
  
  
  
  public void ExecuteAction (String ButtonAction, GUI_Element TriggerElement) {
    switch (ButtonAction.charAt(0)) {
      
      
      
      case ('N'):
        break;
      
      
      
      case ('E'):
        
        if (ButtonAction.startsWith("Enable ")) {
          String ElementToEnableName = ButtonAction.substring(7);
          GUI_Element ElementToEnable = GetGUIElement (ElementToEnableName, TriggerElement);
          if (ElementToEnable != null) {
            ElementToEnable.Enabled = true;
          } else {
            println ("Error in " + TriggerElement + ": tried to enable " + ElementToEnableName + ", but it was null.");
          }
        }
        
        if (ButtonAction.equals("Exit")) exit();
        
        break;
      
      
      
      case ('D'):
        
        if (ButtonAction.startsWith("Disable ")) {
          String ElementToEnableName = ButtonAction.substring(8);
          GUI_Element ElementToDisable = GetGUIElement (ElementToEnableName, TriggerElement);
          if (ElementToDisable != null) {
            ElementToDisable.Enabled = false;
          } else {
            println ("Error in " + TriggerElement + ": tried to disable " + ElementToEnableName + ", but it was null.");
          }
        }
        
        break;
      
      
      
      case ('T'):
        
        if (ButtonAction.startsWith("Toggle ")) {
          String ElementToEnableName = ButtonAction.substring(7);
          GUI_Element ElementToToggle = GetGUIElement (ElementToEnableName, TriggerElement);
          if (ElementToToggle != null) {
            ElementToToggle.Enabled = !ElementToToggle.Enabled;
          } else {
            println ("Error in " + TriggerElement + ": tried to toggle " + ElementToEnableName + ", but it was null.");
          }
        }
        
        break;
      
      
      
      default:
        
        println ("Error in " + TriggerElement + ": action type " + '"' + ButtonAction + '"' + " is unknown.");
      
      
      
    }
  }
  
  
  
  
  
  GUI_Element GetGUIElement (String GUIElementName, GUI_Element StartingElement) {
    if (GUIElementName.startsWith("this.")) {
      
      GUI_Element Output = StartingElement;
      String[] PathTokens = split (GUIElementName.substring(5), '.');
      
      for (String ThisToken : PathTokens) {
        GUI_Element PrevOutput = Output;
        if (ThisToken.equals("Parent")) {
          Output = Output.Parent;
        } else {
          Output = Output.Child(ThisToken);
        }
        if (Output == null) {
          println ("Error in " + StartingElement + " while trying to find [" + GUIElementName + "]: tried to find [" + ThisToken + "] in " + PrevOutput + ", but got null.");
          return null;
        }
      }
      
      return Output;
      
    } else if (GUIElementName.startsWith("all.")) {
      
      GUIElementName = GUIElementName.substring(4);
      for (int i = AllGUIElements.size() - 1; i >= 0; i --) {
        GUI_Element ThisGUIElement = AllGUIElements.get(i);
        if (ThisGUIElement == null) {
          AllGUIElements.remove(i);
          continue;
        }
        if (ThisGUIElement.FullName.equals(GUIElementName)) {
          return ThisGUIElement;
        }
      }
      
      return null;
      
    } else {
      
      println ("Error in " + StartingElement + ": tried to find [" + GUIElementName + "], but it doesn't start with " + '"' + "this." + '"' + " or " + '"' + "all" + '"' + ".");
      return null;
      
    }
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
    
    String SizeIsConsistentWith = GetSetting (Properties, "SizeIsConsistentWith");
    if (SizeIsConsistentWith != null)
      Element.SizeIsConsistentWith = SizeIsConsistentWith;
    
    
    
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
    
    String RenderOrder = GetSetting (Properties, "RenderOrder");
    if (RenderOrder != null)
      Element.RenderOrder = int (RenderOrder);
    
    
    
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
    
    String TextSizeScales = GetSetting (Properties, "TextSizeScales");
    if (TextSizeScales != null)
      Element.TextSizeScales = boolean (TextSizeScales);
    
    String TextMaxHeight = GetSetting (Properties, "TextMaxHeight");
    if (TextMaxHeight != null)
      Element.TextMaxHeight = float (TextMaxHeight);
    
    String TextAlignX = GetSetting (Properties, "TextAlignX");
    if (TextAlignX != null)
      Element.TextAlignX = int (TextAlignX);
    
    String TextAlignY = GetSetting (Properties, "TextAlignY");
    if (TextAlignY != null)
      Element.TextAlignY = int (TextAlignY);
    
    String TextMoveX = GetSetting (Properties, "TextMoveX");
    if (TextMoveX != null)
      Element.TextMoveX = float (TextMoveX);
    
    String TextMoveY = GetSetting (Properties, "TextMoveY");
    if (TextMoveY != null)
      Element.TextMoveY = float (TextMoveY);
    
    
    
    String TextIsEditable = GetSetting (Properties, "TextIsEditable");
    if (TextIsEditable != null)
      Element.TextIsEditable = boolean (TextIsEditable);
    
    String TextResetsOnEdit = GetSetting (Properties, "TextResetsOnEdit");
    if (TextResetsOnEdit != null)
      Element.TextResetsOnEdit = boolean (TextResetsOnEdit);
    
    
    
    String ImageXSize = GetSetting (Properties, "ImageXSize");
    if (ImageXSize != null)
      Element.ImageXSize = float (ImageXSize);
    
    String ImageYSize = GetSetting (Properties, "ImageYSize");
    if (ImageYSize != null)
      Element.ImageYSize = float (ImageYSize);
    
    
    
    String PressedBackgroundColor = GetSetting (Properties, "PressedBackgroundColor");
    if (PressedBackgroundColor != null)
      Element.PressedBackgroundColor = unhex (PressedBackgroundColor);
    
    String UsePressedColor = GetSetting (Properties, "UsePressedColor");
    if (UsePressedColor != null)
      Element.UsePressedColor = boolean (UsePressedColor);
    
    String XMove = GetSetting (Properties, "PressedXMove");
    if (XMove != null)
      Element.PressedXMove = int (XMove);
    
    String YMove = GetSetting (Properties, "PressedYMove");
    if (YMove != null)
      Element.PressedYMove = int (YMove);
    
    String ButtonAction = GetSetting (Properties, "ButtonAction");
    if (ButtonAction != null)
      Element.ButtonAction = ButtonAction;
    
    String ButtonKey = GetSetting (Properties, "ButtonKey");
    if (ButtonKey != null)
      Element.ButtonKey = int (ButtonKey);
    
    String ButtonCharacter = GetSetting (Properties, "ButtonCharacter");
    if (ButtonCharacter != null)
      Element.ButtonKey = ButtonCharacter.charAt(0);
    
    
    
    String CanScroll = GetSetting (Properties, "CanScroll");
    if (CanScroll != null)
      Element.CanScroll = boolean (CanScroll);
    
    String InvertedScrolling = GetSetting (Properties, "InvertedScrolling");
    if (InvertedScrolling != null)
      Element.InvertedScrolling = boolean (InvertedScrolling);
    
    String ScrollSpeedX = GetSetting (Properties, "ScrollSpeedX");
    if (ScrollSpeedX != null)
      Element.ScrollSpeedX = float (ScrollSpeedX);
    
    String ScrollSpeedY = GetSetting (Properties, "ScrollSpeedY");
    if (ScrollSpeedY != null)
      Element.ScrollSpeedY = float (ScrollSpeedY);
    
    String TargetScrollX = GetSetting (Properties, "TargetScrollX");
    if (TargetScrollX != null)
      Element.TargetScrollX = float (TargetScrollX);
    
    String TargetScrollY = GetSetting (Properties, "TargetScrollY");
    if (TargetScrollY != null)
      Element.TargetScrollY = float (TargetScrollY);
    
    String CurrScrollX = GetSetting (Properties, "CurrScrollX");
    if (CurrScrollX != null)
      Element.CurrScrollX = float (CurrScrollX);
    
    String CurrScrollY = GetSetting (Properties, "CurrScrollY");
    if (CurrScrollY != null)
      Element.CurrScrollY = float (CurrScrollY);
    
    String MinScrollX = GetSetting (Properties, "MinScrollX");
    if (MinScrollX != null)
      Element.MinScrollX = float (MinScrollX);
    
    String MaxScrollX = GetSetting (Properties, "MaxScrollX");
    if (MaxScrollX != null)
      Element.MaxScrollX = float (MaxScrollX);
    
    String MinScrollY = GetSetting (Properties, "MinScrollY");
    if (MinScrollY != null)
      Element.MinScrollY = float (MinScrollY);
    
    String MaxScrollY = GetSetting (Properties, "MaxScrollY");
    if (MaxScrollY != null)
      Element.MaxScrollY = float (MaxScrollY);
    
    String ReachTargetSpeed = GetSetting (Properties, "ReachTargetSpeed");
    if (ReachTargetSpeed != null)
      Element.ReachTargetSpeed = float (ReachTargetSpeed);
    
    
    
  }
  
  
  
  
  
  
  
  
  
  
}

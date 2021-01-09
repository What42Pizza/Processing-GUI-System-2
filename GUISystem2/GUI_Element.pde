public class GUI_Element {
  
  
  
  
  
  public String Name = "[Error: The name for this GUI_Element is not set.]";
  
  public boolean HasFrame     = true ;
  public boolean HasText      = false;
  public boolean HasImage     = false;
  public boolean CanBePressed = false; // If this is set to false outside init then Pressed should also be set to false
  
  public float XPos = 0.25;
  public float YPos = 0.25;
  public float XSize = 0.5;
  public float YSize = 0.5;
  
  public String SizeIsConsistentWith = "POSITION";
  
  public color BackgroundColor = color (127);
  public color EdgeColor = color (0);
  public int   EdgeSize = 1;
  
  public boolean Draggable = false;
  public boolean Visible   = true ;
  public boolean Enabled   = true ;
  public boolean RenderChildrenNotInFrame = true;
  public boolean UpdateChildrenNotInFrame = true;
  public int RenderOrder = 1;
  
  public String  Text = "Error: text not set";
  public String  PlaceholderText = "Click to enter text";
  public boolean UsePlaceholderText = true;
  public color   TextColor = color (0);
  public float   TextSize = 0.9;
  public String  TextSizeIsRelativeTo = "FRAME"; // This has to be either "FRAME" or "SCREEN"
  public boolean TextSizeScales = true;
  public float   TextMaxHeight = 0.8;
  public int     TextAlignX = 0;
  public int     TextAlignY = 0;
  public float   TextMoveX = 0;
  public float   TextMoveY = -0.1;
  
  public boolean TextIsEditable  = false; // If this is set to false outside init then TextIsBeingEdited should also be set to false
  public boolean TextResetsOnEdit = true;
  public boolean TextIsBeingEdited = false;
  public boolean PrevTextIsBeingEdited = false;
  
  public PImage Image         ;
  public float  ImageXSize = 1;
  public float  ImageYSize = 1;
  
  public color   PressedBackgroundColor = color (79);
  public boolean UsePressedColor = true;
  public int     PressedXMove = 0;
  public int     PressedYMove = 3;
  public boolean Pressed = false;
  public boolean PrevPressed = false;
  public String  ButtonAction = "None";
  
  public boolean CanScroll = false;
  public boolean InvertedScrolling = false;
  public float   ScrollSpeedX = 0;
  public float   ScrollSpeedY = 1;
  public float   TargetScrollX = 0;
  public float   TargetScrollY = 0;
  public float   CurrScrollX = 0;
  public float   CurrScrollY = 0;
  public float   MinScrollX = 0;
  public float   MinScrollY = 0;
  public float   MaxScrollX = 1000;
  public float   MaxScrollY = 1000;
  public float   ReachTargetSpeed = 0.4;
  
  public ArrayList <GUI_Element> Children = new ArrayList <GUI_Element> ();
  public GUI_Element Parent = null;
  public int FamilyLevel = 0;
  public String FullName = "";
  
  public boolean IsDragging = false;
  public boolean PrevMousePressed = false;
  public int Dragging_StartMouseX;
  public int Dragging_StartMouseY;
  public float Dragging_StartXPos;
  public float Dragging_StartYPos;
  
  public int ScreenXPos  = 0;
  public int ScreenYPos  = 0;
  public int ScreenXSize = 0;
  public int ScreenYSize = 0;
  public int ScreenPressedXPos = 0;
  public int ScreenPressedYPos = 0;
  
  public boolean Deleted = false;
  
  
  
  
  
  
  
  
  
  
  public GUI_Element (String NameIn) {
    Name = NameIn;
    FullName = NameIn;
    GUIFunctions.AllGUIElements.add(this);
  }
  
  public GUI_Element (String ElementTypeIn, String NameIn) {
    SetBasicType (ElementTypeIn);
    Name = NameIn;
    FullName = NameIn;
    GUIFunctions.AllGUIElements.add(this);
  }
  
  public GUI_Element (String NameIn, String[] PropertiesIn) {
    Name = NameIn;
    FullName = NameIn;
    GUIFunctions.SetGUIElementProperties (this, PropertiesIn);
    GUIFunctions.AllGUIElements.add(this);
  }
  
  public GUI_Element (String[] PropertiesIn) {
    GUIFunctions.SetGUIElementProperties (this, PropertiesIn);
    FullName = Name;
    GUIFunctions.AllGUIElements.add(this);
  }
  
  public GUI_Element (String NameIn, File ElementFolder) {
    this (ElementFolder);
    Name = NameIn;
    FullName = NameIn;
    GUIFunctions.AllGUIElements.add(this);
  }
  
  public GUI_Element (File ElementFolder) {
    
    if (ElementFolder == null       ) {println ("Error while constructing GUI_Element: The given File cannot be null"); return;}
    if (!ElementFolder.exists()     ) {println ("Error while constructing GUI_Element: The given File (" + ElementFolder.getAbsolutePath() + ") must exist"); return;}
    if (!ElementFolder.isDirectory()) {println ("Error while constructing GUI_Element: The given File (" + ElementFolder.getAbsolutePath() + ") must be a folder"); return;}
    
    File PropertiesFile = GUIFunctions.GetChildFile (ElementFolder, "Properties.txt");
    if (PropertiesFile == null) {println ("Error while constructing GUI_Element: No Properties.txt file found in " + ElementFolder.getAbsolutePath()); return;}
    
    String[] Properties = loadStrings (PropertiesFile);
    GUIFunctions.SetGUIElementProperties (this, Properties);
    FullName = Name;
    
    File[] FolderDir = ElementFolder.listFiles();
    
    for (File F : FolderDir) {
      String FName = F.getName();
      if (FName.startsWith("Child.") && F.isDirectory()) { // Yes, String has .startsWith()
        AddChild (new GUI_Element (F));
      }
    }
    
    GUIFunctions.AllGUIElements.add(this);
    
  }
  
  
  
  
  
  
  
  
  
  
  public void SetBasicType (String ElementTypeIn) {
    switch (ElementTypeIn) {
      
      
      case ("Holder"):
        HasFrame     = false;
        HasText      = false;
        HasImage     = false;
        CanBePressed = false;
        break;
      
      
      case ("Frame"):
        HasFrame     = true ;
        HasText      = false;
        HasImage     = false;
        CanBePressed = false;
        break;
      
      case ("TextFrame"):
        HasFrame     = true ;
        HasText      = true ;
        HasImage     = false;
        CanBePressed = false;
        break;
      
      case ("TextBox"):
        HasFrame       = true ;
        HasText        = true ;
        HasImage       = false;
        CanBePressed   = false;
        TextIsEditable = true ;
        break;
      
      case ("ImageFrame"):
        HasFrame     = true ;
        HasText      = false;
        HasImage     = true ;
        CanBePressed = false;
        break;
      
      
      case ("ScrollingFrame"):
        HasFrame     = true ;
        HasText      = false;
        HasImage     = false;
        CanBePressed = false;
        CanScroll    = true ;
        break;
      
      
      case ("Button"):
        HasFrame     = true ;
        HasImage     = false;
        HasText      = false;
        CanBePressed = true ;
        break;
      
      case ("TextButton"):
        HasFrame     = true ;
        HasText      = true ;
        HasImage     = false;
        CanBePressed = true ;
        break;
      
      case ("ImageButton"):
        HasFrame     = true ;
        HasText      = false;
        HasImage     = true ;
        CanBePressed = true ;
        break;
      
      
      default:
        println ("Error in " + this + ": Element type " + '"' + ElementTypeIn + '"' + " was not understood.");
        break;
      
      
    }
  }
  
  
  
  /*
  public void LoadImage (String ImageURL) {
    ImageURLToLoad = ImageURL;
    ElementToLoadImageFor = this;
    thread ("Threaded_LoadImage");
  }
  */
  
  
  
  
  
  
  
  
  
  
  public void Render() {
    
    PrevTextIsBeingEdited = TextIsBeingEdited;
    
    if (Deleted) {
      println ("ERROR: " + this + " HAS BEEN DELETED. REMOVE ALL POINTERS TO THIS OBJECT.");
      return;
    }
    
    Update();
    CalcScreenData();
    
    if (Visible && Enabled) {
      RenderFrame();
      RenderImage();
      RenderText();
    }
    
    if (Enabled)
      RenderChildren();
    
    PrevMousePressed = mousePressed;
    PrevPressed = Pressed;
    
  }
  
  
  
  public void Update() {
    
    if (this.JustClicked() && !ButtonAction.equals("None"))
      GUIFunctions.ExecuteAction (ButtonAction, this);
    
    if (Parent == null) {
      GUIFunctions.GetNewKeyPresses(); // Just update keys and scroll (if this is a top ancestor) because not updating them can have bad effects when they are finally called
      GUIFunctions.GetScrollAmount();
    }
    
    if (Draggable)
      UpdateDragging();
    
    if (CanBePressed)
      UpdatePressed();
    
    if (TextIsEditable)
      UpdateTextEditing();
    
    UpdateScrolling();
    
  }
  
  
  
  public void UpdateDragging() {
    
    if (IsDragging) {
      
      if (!mousePressed) {
        IsDragging = false;
        return;
      }
      
      XPos = Dragging_StartXPos - GUIFunctions.GetFrameX (Dragging_StartMouseX - mouseX);
      YPos = Dragging_StartYPos - GUIFunctions.GetFrameY (Dragging_StartMouseY - mouseY);
      
    }
    
    if (this.JustClicked()) { // I know the 'this.' is needed but it makes the name more understandable
      IsDragging = true;
      Dragging_StartMouseX = mouseX;
      Dragging_StartMouseY = mouseY;
      Dragging_StartXPos = XPos;
      Dragging_StartYPos = YPos;
    }
    
  }
  
  
  
  public void UpdatePressed() {
    
    if (Pressed) {
      
      if (!mousePressed) // Stop being pressed if mouse is released
        Pressed = false;
        
      if (!this.HasMouseHovering()) // Stop being pressed if mouse is no longer hovering
        Pressed = false;
      
    } else {
      if (this.JustClicked()) // Start being pressed if just not clicked
        Pressed = true;
      
    }
  }
  
  
  
  public void UpdateTextEditing() {
    
    if (GUIFunctions.KeyPressed (27) || GUIFunctions.KeyPressed (10) || (mousePressed && !PrevMousePressed && !this.HasMouseHovering())) {
      TextIsBeingEdited = false;
      if (Text.equals("") && UsePlaceholderText)
        Text = PlaceholderText;
    }
    
    if (JustClicked()) {
      TextIsBeingEdited = true;
      if (TextResetsOnEdit)
        Text = "";
    }
    
    if (TextIsBeingEdited) {
      for (Character C : GUIFunctions.GetNewKeyPresses()) {
        
        if (C > 31 && C < 127)
          Text += C;
        
        if (C == 8)
          Text = Text.substring (0, Text.length() - 1);
        
      }
    }
    
  }
  
  
  
  public void UpdateScrolling() {
    
    if (CanScroll && HasMouseHovering()) {
      
      float MouseScrollAmount = GUIFunctions.GetScrollAmount() * (InvertedScrolling ? 1 : -1); // Get amount scrolled
      if (MouseScrollAmount != 0) {
        
        float TotalScreenPercentX = (float) ScreenXSize / width ; // Get screen size because smaller frames need more scroll added to ScrollAmount
        float TotalScreenPercentY = (float) ScreenYSize / height;
        
        float ScrollAmountX = (float) 1/TotalScreenPercentX * ScrollSpeedX / 75 * MouseScrollAmount; // Determin amount of scrolling needed
        float ScrollAmountY = (float) 1/TotalScreenPercentY * ScrollSpeedY / 75 * MouseScrollAmount; // 1/TotalScPer is because a frame of 1/3 size of screen needs 3x more scrolling. * ScrollSpeed is to make it faster. / 100 is to slow it down because normally it's way too much. * MouseScrollAmount is to make it react to the actual amount of scrolling.
        
        TargetScrollX += ScrollAmountX; // Add scrolling
        TargetScrollY += ScrollAmountY;
        
        ConstrainScroll();
        
      }
    }
    
    CurrScrollX += (TargetScrollX - CurrScrollX) * ReachTargetSpeed;
    CurrScrollY += (TargetScrollY - CurrScrollY) * ReachTargetSpeed;
    
  }
  
  
  
  public void ConstrainScroll() {
    if (InvertedScrolling) {
      TargetScrollX = constrain(TargetScrollX, MinScrollX, MaxScrollX);
      TargetScrollY = constrain(TargetScrollY, MinScrollY, MaxScrollY);
    } else {
      TargetScrollX = constrain(TargetScrollX, MaxScrollX * -1, MinScrollX);
      TargetScrollY = constrain(TargetScrollY, MaxScrollY * -1, MinScrollY);
    }
  }
  
  
  
  
  
  public void RenderFrame() {
    
    if (HasFrame) {
      if (EdgeSize == 0) {
        noStroke();
      } else {
        stroke (EdgeColor);
        strokeWeight (EdgeSize);
      }
      if (Pressed) {
        fill (UsePressedColor? PressedBackgroundColor : BackgroundColor);
        rect (ScreenPressedXPos, ScreenPressedYPos, ScreenXSize, ScreenYSize);
      } else {
        fill (BackgroundColor);
        rect (ScreenXPos, ScreenYPos, ScreenXSize, ScreenYSize);
      }
    }
    
  }
  
  
  
  public void RenderImage() {
    
    if (HasImage && Image != null) {
      if (Pressed) {
        image (Image, ScreenPressedXPos, ScreenPressedYPos, ScreenXSize * ImageXSize, ScreenYSize * ImageYSize);
      } else {
        image (Image, ScreenXPos, ScreenYPos, ScreenXSize * ImageXSize, ScreenYSize * ImageYSize);
      }
    }
    
  }
  
  
  
  public void RenderText() {
    
    if (HasText) {
      String TextToDisplay = Text;
      if (TextIsBeingEdited) TextToDisplay += (millis() % 1000 > 500 ? "|" : " ");
      GUIFunctions.SetTextAlign (TextAlignX, TextAlignY); // Runs textAlign() with correct values
      GUIFunctions.SetTextSize (TextToDisplay, TextSize, TextSizeIsRelativeTo, TextSizeScales, ScreenXSize, (int) (ScreenYSize * TextMaxHeight)); // Runs textSize() with correct values
      float TextXPos = XPos + XSize / 2 * (TextAlignX + 1);
      float TextYPos = YPos + YSize / 2 * (TextAlignY + 1);
      int TextScreenX = GUIFunctions.GetScreenX (TextXPos) + (int) (g.textSize * TextMoveX);
      int TextScreenY = GUIFunctions.GetScreenY (TextYPos) + (int) (g.textSize * TextMoveY);
      if (Pressed) {
        TextScreenX += PressedXMove;
        TextScreenY += PressedYMove;
      }
      fill (TextColor);
      text (TextToDisplay, TextScreenX, TextScreenY);
    }
    
  }
  
  
  
  public void CalcScreenData() {
    
    ScreenXPos = GUIFunctions.GetScreenX(XPos);
    ScreenYPos = GUIFunctions.GetScreenY(YPos);
    
    switch (SizeIsConsistentWith) {
      
      case ("POSITION"):
        int ScreenXEnd, ScreenYEnd;
        ScreenXEnd  = GUIFunctions.GetScreenX (XPos + XSize);
        ScreenXSize = ScreenXEnd - ScreenXPos;
        ScreenYEnd  = GUIFunctions.GetScreenY (YPos + YSize);
        ScreenYSize = ScreenYEnd - ScreenYPos;
        break;
      
      case ("ITSELF"):
        ScreenXSize = (int) (XSize * CustMatrix_ScaleX * width);
        ScreenYSize = (int) (YSize * CustMatrix_ScaleY * height);
        break;
      
      default:
        println ("Error in " + this + ": SizeIsConsitantWith has to be either " + '"' + "POSITION" + '"' + " or " + '"' + "ITSELF" + '"' + ".");
        break;
      
    }
    
    ScreenPressedXPos = ScreenXPos + PressedXMove;
    ScreenPressedYPos = ScreenYPos + PressedYMove;
    
    /*
    To understand the extra math behind ITSELF, for ScreenX(/Y)Size you can look at GUIFunctions.GetScreenX as f(x), which equals (x * C + D) * E, where C = ScaleX, D = TranslateX, and E = width
    This means f(a + b) = aCE + bCE + DE, but f(a) + f(b) = aCE + bCE + 2DE
    If you consider PScrollX + XPos as a, and XSize as b, then what POSITION is calculating is f(a) - f(a + b), which equals aCE + bCE + DE - aCE - DE
    aCE and DE cancle out, leaving just bCE
    To calculate this easier (and more consistant), we skip all the extra steps and just calculate bCE.
    */
    
  }
  
  
  
  public void RenderChildren() {
    PushMatrix();
    Translate (XPos + CurrScrollX * XSize, YPos + CurrScrollY * YSize);
    Scale (1 / XSize, 1 / YSize);
    
    /*
    for (GUI_Element E : Children) { // Simplified version of code below (this code does the NotInFrame checks for every child instead of just once)
      if (E.IsInFrame) {
        E.Render();
      } else {
        if (RenderChildrenNotInFrame) {
          E.Render();
        } else if (UpdateChildrenNotInFrame) {
          E.Render();
        }
      }
    }
    */
    
    if (RenderChildrenNotInFrame) { // Always render and update (Render = true, Update = true)
      if (!UpdateChildrenNotInFrame) println ("Warning in " + this + ": UpdateChildrenNotInFrame is treated as true when RenderChildrenNotInFrame is true.");
      
      for (GUI_Element E : Children) {
        E.Render();
      }
      
    } else {
      if (UpdateChildrenNotInFrame) { // Don't always render, but always update (Render = false, Update = true)
        
        for (GUI_Element E : Children) {
          if (E.IsInFrame()) {
            E.Render();
          } else {
            E.Update();
          }
        }
        
      } else { // Don't always render or update (Render = false, Update = false)
        
        for (GUI_Element E : Children) {
          if (E.IsInFrame()) {
            E.Render();
          }
        }
        
      }
    }
    
    PopMatrix();
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  public void AddChild (GUI_Element NewChild) {
    
    if (NewChild == null) {
      println ("Error in " + this + ": You cannot add a null child.");
      return;
    }
    
    boolean Added = false;
    for (int i = Children.size() - 1; i >= 0; i --) {
      if (NewChild.RenderOrder >= Children.get(i).RenderOrder) {
        Children.add(i+1, NewChild);
        Added = true;
        break;
      }
    }
    if (!Added) Children.add(0, NewChild);
    
    NewChild.Parent = this;
    NewChild.FamilyLevel = FamilyLevel + 1;
    NewChild.FullName = this.FullName + "." + NewChild.Name;
    
  }
  
  
  
  public void AddChild (int Index, GUI_Element NewChild) {
    if (NewChild == null) {
      println ("Error in " + this + ": You cannot add a null child.");
      return;
    }
    Children.add (Index, NewChild);
    NewChild.Parent = this;
    NewChild.FamilyLevel = FamilyLevel + 1;
  }
  
  
  
  public GUI_Element Child (String ChildName) {
    if (ChildName == null) {
      println ("Error in " + this + ": You cannot search for a child with a null name.");
      return null;
    }
    for (GUI_Element E : Children) {
      if (E.Name.equals(ChildName)) {
        return E;
      }
    }
    return null;
  }
  
  
  
  public ArrayList <GUI_Element> AllDescendants() {
    //return AddAllChildren (new ArrayList <GUI_Element> ()); // This doesn't exactly work because it adds itself as a child, which isn't wanted
    ArrayList <GUI_Element> Output = new ArrayList <GUI_Element> ();
    for (GUI_Element E : Children) {
      E.AddAllDescendants (Output);
    }
    return Output;
  }
  
  public void AddAllDescendants (ArrayList <GUI_Element> OutputIn) {
    OutputIn.add (this);
    for (GUI_Element E : Children) {
      E.AddAllDescendants (OutputIn);
    }
    // No retrun because it modifies the input array
  }
  
  
  
  public void ReplaceChild (String ChildName, GUI_Element NewChild) {
    for (int i = 0; i < Children.size(); i ++) {
      if (Children.get(i).Name.equals(ChildName)) {
        Children.remove (i);
        Children.add (i, NewChild);
        return;
      }
    }
    Children.add (NewChild);
  }
  
  
  
  public GUI_Element Descendant (String DescendantName) {
    
    if (Name.equals(DescendantName))
      return this;
    
    for (GUI_Element E : Children) { // Check if any children are Descendant
      if (E.Name.equals(DescendantName)) {
        return E;
      }
    }
    
    for (GUI_Element E : Children) { // Check if any children's descendants are Descendant
      GUI_Element Descendant = E.Descendant (DescendantName);
      if (Descendant != null) {
        return Descendant;
      }
    }
    
    return null; // No descendants found named Descendant
    
  }
  
  
  
  public GUI_Element Ancestor (String AncestorName) {
    GUI_Element Ancestor = Parent; // Needs better name
    while (!(Ancestor == null || Ancestor.Name.equals(AncestorName))) {
      Ancestor = Ancestor.Parent;
    }
    return Ancestor;
  }
  
  
  
  public GUI_Element TopAncestor() {
    GUI_Element Ancestor = this;
    while (Ancestor.Parent != null) { // If the ancestor has a parent, continue the chain
      Ancestor = Ancestor.Parent;
    }
    return Ancestor;
  }
  
  
  
  public ArrayList <GUI_Element> AllAncestors() {
    ArrayList <GUI_Element> Output = new ArrayList <GUI_Element> ();
    //if (Parent == null) return Output; // This isn't needed because Ancestor.Parnet != null would immediatly be false if this one is true
    GUI_Element Ancestor = this;
    while (Ancestor.Parent != null) {
      Ancestor = Ancestor.Parent;
      Output.add (Ancestor);
    }
    return Output;
  }
  
  
  
  
  
  
  
  
  
  
  public void Delete() { // Remove all pointers to this and this's(?) children
    ArrayList <GUI_Element> AllGUIElements = GUIFunctions.AllGUIElements;
    
    for (int i = 0; i < AllGUIElements.size(); i ++) { // Remove from GUIFunctions.AllGUIElements
      GUI_Element E = AllGUIElements.get(i);
      if (E == this) {
        AllGUIElements.remove(i); // This is a pointer, so it removes this from GUIFunctions
        break;
      }
    }
    
    DeleteChildren();
    
    if (Parent != null) {
      for (int i = 0; i < Parent.Children.size(); i ++) { // Remove this from Parent.Children
        if (Parent.Children.get(i) == this) {
          Parent.Children.remove(i);
          break;
        }
      }
    }
    
    Children = null; // Remove last pointers
    Parent = null;
    
    Deleted = true; // Set as deleted in case user holds more pointers
    
  }
  
  
  
  void DeleteChildren() {
    ArrayList <GUI_Element> ChildrenCopy = new ArrayList <GUI_Element> ();
    for (GUI_Element E : Children) {
      ChildrenCopy.add(E);
    }
    for (GUI_Element E : ChildrenCopy) { // Have all children delete themselves too
      E.Delete();
    }
  }
  
  
  
  
  
  void SetRenderOrder (int NewOrder) {
    RenderOrder = NewOrder;
    if (Parent != null) {
      
      ArrayList <GUI_Element> PChildren = Parent.Children; // Remove from Parent's children
      for (int i = 0; i < PChildren.size(); i ++) {
        if (PChildren.get(i) == this) {
          PChildren.remove(i);
          break;
        }
      }
      
      boolean Added = false;
      for (int i = PChildren.size() - 1; i >= 0; i --) { // Add to Parent's children in correct location
        if (RenderOrder > PChildren.get(i).RenderOrder) {
          PChildren.add(i, this);
          Added = true;
          break;
        }
      }
      if (!Added) PChildren.add(0, this);
      
    }
  }
  
  
  
  
  
  
  
  
  
  
  public boolean HasMouseHovering() {
    /*
    int ScreenXStart = GUIFunctions.GetScreenX (XPos        );
    int ScreenXEnd   = GUIFunctions.GetScreenX (XPos + XSize);
    int ScreenYStart = GUIFunctions.GetScreenY (YPos        );
    int ScreenYEnd   = GUIFunctions.GetScreenY (YPos + YSize);
    return mouseX >= ScreenXStart && mouseX <= ScreenXEnd && mouseY >= ScreenYStart && mouseY <= ScreenYEnd;
    */
    return Enabled && (IsDragging || (mouseX > ScreenXPos && mouseX < ScreenXPos + ScreenXSize && mouseY > ScreenYPos && mouseY < ScreenYPos + ScreenYSize));
  }
  
  
  
  public boolean JustClicked() {
    return mousePressed && !PrevMousePressed && this.HasMouseHovering();
  }
  
  public boolean JustReleased() {
    return !Pressed && PrevPressed;
  }
  
  
  
  public boolean UserStartedEditingText() {
    return TextIsBeingEdited && !PrevTextIsBeingEdited;
  }
  
  public boolean UserStoppedEditingText() {
    return !TextIsBeingEdited && PrevTextIsBeingEdited;
  }
  
  
  
  public boolean IsInFrame() {
    
    if (Parent == null) {
      return XPos < 1 &&
             XPos + XSize > 0 &&
             YPos < 1 &&
             YPos + YSize > 0;
      
    } else {
      float PScrollX = Parent.CurrScrollX, PScrollY = Parent.CurrScrollY;
      return PScrollX + XPos < 1 &&
             PScrollX + XPos + XSize > 0 &&
             PScrollY + YPos < 1 &&
             PScrollY + YPos + YSize > 0;
      
    }
  }
  
  
  
  
  
  
  
  
  
  
  public String toString() {
    return "[GUI_Element " + FullName + ']';
  }
  
  
  
  
  
  
  
  
  
  
}

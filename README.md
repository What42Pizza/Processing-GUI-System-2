# Processing GUI System 2

# THIS IS A WORK IN PROGRESS.

<br />

This is a system you can use in Processing that allows you to easily create GUIs. This was designed in Processing 3.5.3, so you should be using at least that. It might work with earlier versions, but it hasn't been tested.

The main file (GUISystem2/GUISystem2.pde) shows some basic uses for the different element types. You can use it to start building your own GUI. To use this in your own project, you will need to copy over GUI_Element.pde and GUI_Functions.pde.

There are different basic types of GUI elements which can be used as presets, but everything about the GUI element can be configured.

<br />

### YOU NEED TO HAVE THE FOLLOWING CODE AT THE START OF YOUR PROGRAM FOR THIS TO WORK:

```
GUI_Functions GUIFunctions = new GUI_Functions(); // YOU NEED TO HAVE THIS AT THE START OF YOUR PROGRAM FOR THIS TO WORK

void keyPressed() {
  GUIFunctions.keyPressed();
  if (key == 27) key = 0;
}

void keyReleased() { // NO LONGER OPTIONAL
  GUIFunctions.keyReleased();
}

void mouseWheel (MouseEvent E) {
  GUIFunctions.mouseWheel(E);
}
```

<br />
<br />
<br />
<br />
<br />

### Basic Element Types:

- Holder
- Frame
- TextFrame
- TextBox
- ImageFrame
- Button
- TextButton
- ImageButton

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

## GUI_Element Vars:

<br />

- String Name (default: "[Error: The name for this GUI_Element is not set.]")

<br />

- boolean HasFrame (default: true)
- boolean HasText (default: false)
- boolean HasImage (default: false)
- boolean CanBePressed (default: false, NOTE: if this is set to false outside init, set Pressed to false too)

<br />

- float XPos (default: 0.25)
- float YPos (default: 0.25)
- float XSize (default: 0.5)
- float YSize (default: 0.5)

<br />

- int XPixelOffset (default: 0, NOTE: this does not affect children)
- int YPixelOffset (default: 0)
- int XSizePixelOffset (default: 0)
- int YSizePixelOffset (default: 0)

<br />

- boolean SizeIsConsistentWith (default: "POSITION", has to be either "POSITION" or "ITSELF")

<br />

- color BackgroundColor (default: color (127))
- color EdgeColor (default: color (0))
- int EdgeSize (default: 1)

<br />

- boolean Draggable (default: false)
- boolean Visible (default: true)
- boolean Enabled (default: true)
- boolean RenderChildrenNotInFrame (default: true)
- boolean UpdateChildrenNotInFrame (default: true)

<br />

- String Text (default: "Error: text not set")
- String PlaceholderText (default: "Click to edit text")
- boolean UsePlaceholderText (default: true)
- color TextColor (default: color (0))
- float TextSize (default: 0.9)
- String TextSizeIsRelativeTo (default: "FRAME", has to be either "FRAME" or "SCREEN")
- boolean TextSizeScales (default: true)
- float TextMaxHeight (default: 0.8)
- int TextAlignX (default: 0, 1 = RIGHT, 0 = CENTER, -1 = LEFT)
- int TextAlignY (default: 0, 1 = BOTTOM, 0 = CENTER, -1 = TOP)
- float TextXMove (default: 0, relative to text size (not TextSize))
- float TextYMove (default: -0.1, relative to text size (not TextSize))

<br />

- boolean TextIsEditable (default: false, NOTE: if this is set to false outside init, set TextIsBeingEdited to false too)
- boolean TextResetsOnEdit (default: true)
- String TextResetsIfEqualing (default: null, (only affects when edit starts))
- Action OnTextFinished (default: null, see bottom of README)
- boolean TextIsBeingEdited (read only)
- boolean PrevTextIsBeingEdited (read only)

<br />

- PImage Image
- float ImageXSize (default: 1)
- float ImageYSize (default: 1)

<br />

- PressedBackgroundColor (default: color (79))
- boolean UsePressedColor (default: false)
- int PressedXMove (default: 0)
- int PressedYMove (default: 3)
- boolean Pressed (read only)
- boolean PrevPressed (read only)
- String ButtonAction (Default: "None", see bottom of README)
- Action OnButtonPressed (Default: null, see bottom of README)
- int ButtonKey (default: -1, can also be set in Properties with "ButtonCharacter" followed by a char)

<br />

- boolean CanScroll (default: false)
- boolean InvertedScrolling (default: false)
- float ScrollSpeedX (default: 0)
- float ScrollSpeedY (default: 1)
- float MinScrollX (default: 0, NOTE: make sure to call ConstrainScroll() after changing any of these)
- float MinScrollY (default: 0)
- float MaxScrollX (default: 1000)
- float MaxScrollY (default: 1000)
- GUI_Element[] ScrollIsSyncedWith (default: null, has to be set on both elements to be synced (name is 'scroll is', not 'scrolll s'))

<br />

- float TargetScrollX (default: 0, this is where the children are scrolling to)
- float TargetScrollY (default: 0)
- float CurrScrollX (default: 0, this is where the children currently are)
- float CurrScrollY (default: 0)
- float PrevScrollX (default: 0)
- float PrevScrollY (default: 0)
- float ReachTargetSpeed (default: 0.4, this is the percentage the children will move each frame)

<br />

- ArrayList <GUI_Element> Children (default: new ArrayList <GUI_Element> ())
- GUI_Element Parent (default: null)
- int FamilyLevel (default: 0)
- String FullName

<br />

- int ScreenXPos (read only, these only updates when Render() is called)
- int ScreenYPos (read only)
- int ScreenXSize (read only)
- int ScreenYSize (read only)
- int ScreenPressedXPos (read only)
- int ScreenPressedYPos (read only)

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

## GUI_Element Functions:

<br />

- void Render()  (this calls Update())
- void Update()
- void RenderWOUpdate()
- void RenderThis()  (doesn't call Render() on children)
- void UpdateThis()

<br />

- boolean JustClicked()
- boolean JustReleased()
- boolean HasMouseHovering()
- boolean UserStartedEditingText()
- boolean UserStoppedEditingText()
- boolean IsInFrame()

<br />

- void AddChild (GUI_Element NewChild)
- void AddChild (int ChildIndex, GUI_Element NewChild)
- void ReplaceChild (String ChildName, GUI_Element NewChild)
- GUI_Element Child (String ChildName)
- GUI_Element Descendant (String DescendantName)
- ArrayList <GUI_Element> AllDescendants()
- GUI_Element Ancestor (String AncestorName)
- GUI_Element TopAncestor()
- ArrayList <GUI_Element> AllAncestors()

<br />

- String toString()

<br />
<br />
<br />

### Internal functions:

<br />

- void RenderBody()
- void RenderChildren()

<br />

- void Update()
- void UpdateDragging()
- void UpdatePressed()
- void UpdateTextEditing()

<br />

- void AddAllDescendants (ArrayList <GUI_Element> DescendantListIn) (this adds all the itself and all of its descendants to DescendantListIn (and yes, it is a void))

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

## GUI_Element Constructors:

<br />

- GUI_Element (String Name)
- GUI_Element (String BasicElementType, String Name)
- GUI_Element (String Name, String[] Properties)
- GUI_Element (String[] Properties)
- GUI_Element (String Name, File ElementFolder)
- GUI_Element (File ElementFolder)

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

## Basic Element Type Details

<br />
<br />

### Holder:

- HasFrame: false
- HasText: false
- HasImage: false

<br />
<br />

### Frame:

- HasFrame: true

<br />
<br />

### TextFrame:

- HasFrame: true
- HasText: true

<br />
<br />

### TextBox:

- HasFrame: true
- HasText: true
- TextIsEditable: true

<br />
<br />

### ImageFrame:

- HasFrame: true
- HasImage: true

<br />
<br />

### ScrollingFrame:

- HasFrame: true
- CanScroll: true

<br />
<br />

### Button:

- HasFrame: true
- CanBePressed: true

<br />
<br />

### TextButton:

- HasFrame: true
- HasText: true
- CanBePressed: true

<br />
<br />

### ImageButton:

- HasFrame: true
- HasImage: true
- CanBePressed: true

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

## Using (String[] Properties) constructors:

<br />

This constructor is used for initializing a GUI_Element from a list of properties.

You can use this to set any variable you want, as long as it's listed in this readme and it isn't read only. To do so, you need one of the Strings to be the name of the variable plus a colon at the end and the next String to be the specified value. For example, if you enter this: new String[] {"Name:", "ExampleName"} then it would set its Name to "ExampleName".

<br />
<br />
<br />
<br />
<br />

## Using (File ElementFolder) constructors:

This constructor is used for loading a GUI from files.

The File given has to be a folder, and it has to have a file named Properties.txt. The Properties file holds information the same way that it would be given to a (String[] Settings) constructor.

FrameFolder can also have other folders in it, and they would be the frame's children. In order for it to recognized as a child, it has to start with "Child." followed by the type of class it is. You can place another period if you want to add addition text.

<br />

Here's an example of how you would set up a GUI that loads GUI/StartingFrame:

- GUI
  - StartingFrame
    - Properties.txt
    - Child.ThisIsANestedFrame
      - Properties.txt
      - Child.ThisIsAnotherNestedFrame
        - Properties.txt

<br />
<br />
<br />
<br />
<br />

## Using ButtonAction

This is describes what happens when this GUI_Element is clicked. It is usually "None", which does nothing. There are currently 4 other options for what you can use:

- Enable [GUI_Element]
- Disable [GUI_Element]
- Toggle [GUI_Element]
- Exit

They all do what you'd expect, so the only thing I need to explain is what to put in [GUI_Element]. It HAS TO start with either "all." or "this.". When it starts will "all.", it is referring to any GUI_Element that has ever been created. After the "all." is the FullName of the GUI_Element. For example, you can have ButtonAction set to "Enable all.StartingFrame.ThisIsANestedFrame".

The other option is "this.", which specifies a relative GUI_Element that is somewhere in the same family. After the "this.", you can chain together as many tokens as you want, separated with a period. These tokens have to be either "Parent" or the name of a child. For example, ThisIsAnotherNestedFrame could have ButtonAction be "Enable this.Parent.Parent.ThisIsANestedFrame", though that's not recommended.

<br />
<br />
<br />
<br />
<br />

## Using CustomAction

This allows you to add code to run whenever this GUI_Element is clicked. CustomAction is of type Action, which is a class used by GUI System 2 to define custom code. To use the Action class, you must make a class extending it that overrides the method 'public void Run (GUI_Element)''. Here is an example of an easy way to do that:

```
ExampleButton.CustomAction = new Action() {
  @Override
  public void Run (GUI_Element This) {
    println ("The button has been clicked");
  }
}
```

Now, ExampleButton will print that text whenever it is clicked. Also, the argument 'This' is the button that called the function.

NOTE: Do not use this to edit the element's family tree. If you do so, you'll probably run into problems with ConcurrentModificationException.

<br />
<br />
<br />
<br />
<br />

### SizeIsConsistentWith

This was added because text can look weird while the frame is moving. When set to "POSITION", the size might change by 1 or 2 pixels, but there will never be a gap between GUI Elements when there shouldn't be. When this is set to "ITSELF", the size will never change (unless the Size variables change), but there may be a gap between GUI Elements when there shouldn't be.

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

Last updated 01/29/21
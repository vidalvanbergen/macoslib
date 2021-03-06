#tag Window
Begin Window StringExtensionsExampleWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   648
   ImplicitInstance=   True
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   False
   Title           =   "String Extensions"
   Visible         =   True
   Width           =   1019
   Begin TabPanel TabPanel1
      AutoDeactivate  =   True
      Bold            =   False
      Enabled         =   True
      Height          =   635
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   1
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Panels          =   ""
      Scope           =   0
      SmallTabs       =   False
      TabDefinition   =   "Examples 1"
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   0
      Transparent     =   False
      Underline       =   False
      Value           =   0
      Visible         =   True
      Width           =   1009
      Begin Label Label1
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   40
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   12
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   True
         Scope           =   0
         Selectable      =   False
         TabIndex        =   0
         TabPanelIndex   =   1
         TabStop         =   True
         TextAlign       =   0
         TextColor       =   &c000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   46
         Transparent     =   False
         Underline       =   False
         Value           =   "It is sometimes useful to be able to get a substring before or after some text or between two tags, e.g. when processing some Shell result. Macoslib allows you to do that. You can try it below."
         Visible         =   True
         Width           =   987
      End
      Begin Label Label2
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   12
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   1
         TabPanelIndex   =   1
         TabStop         =   True
         TextAlign       =   0
         TextColor       =   &c000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   123
         Transparent     =   False
         Underline       =   False
         Value           =   "Source:"
         Visible         =   True
         Width           =   52
      End
      Begin Label Label3
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   12
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   2
         TabPanelIndex   =   1
         TabStop         =   True
         TextAlign       =   0
         TextColor       =   &c000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   201
         Transparent     =   False
         Underline       =   False
         Value           =   "Substring #1:"
         Visible         =   True
         Width           =   91
      End
      Begin Label Label4
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   12
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   3
         TabPanelIndex   =   1
         TabStop         =   True
         TextAlign       =   0
         TextColor       =   &c000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   230
         Transparent     =   False
         Underline       =   False
         Value           =   "Substring #2:"
         Visible         =   True
         Width           =   91
      End
      Begin TextArea SrcTA
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   True
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   66
         HelpTag         =   ""
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   115
         LimitText       =   0
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Multiline       =   True
         ReadOnly        =   False
         Scope           =   0
         ScrollbarHorizontal=   False
         ScrollbarVertical=   True
         Styled          =   True
         TabIndex        =   4
         TabPanelIndex   =   1
         TabStop         =   True
         TextColor       =   &c000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   122
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   0
         UseFocusRing    =   True
         Value           =   "name=Some string;"
         Visible         =   True
         Width           =   878
      End
      Begin TextArea SubstrTA1
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   True
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   21
         HelpTag         =   ""
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   115
         LimitText       =   0
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Multiline       =   True
         ReadOnly        =   False
         Scope           =   0
         ScrollbarHorizontal=   False
         ScrollbarVertical=   True
         Styled          =   True
         TabIndex        =   5
         TabPanelIndex   =   1
         TabStop         =   True
         TextColor       =   &c000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   200
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   0
         UseFocusRing    =   True
         Value           =   "name="
         Visible         =   True
         Width           =   878
      End
      Begin TextArea SubstrTA2
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   True
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   21
         HelpTag         =   ""
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   115
         LimitText       =   0
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Multiline       =   True
         ReadOnly        =   False
         Scope           =   0
         ScrollbarHorizontal=   False
         ScrollbarVertical=   True
         Styled          =   True
         TabIndex        =   6
         TabPanelIndex   =   1
         TabStop         =   True
         TextColor       =   &c000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   229
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   0
         UseFocusRing    =   True
         Value           =   ";"
         Visible         =   True
         Width           =   878
      End
      Begin PushButton BeforeBTN
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "String before substring #1"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   115
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   7
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   274
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   218
      End
      Begin CheckBox BeforeCB
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Return empty string if substring #1 was not found"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   347
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   8
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   274
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   646
      End
      Begin CheckBox AfterCB
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Include substring #1 in the result"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   347
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   9
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   303
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   646
      End
      Begin PushButton AfterBTN
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "String after substring #1"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   115
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   10
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   303
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   218
      End
      Begin CheckBox Inc1CB
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Include substring #1 in the result"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   156
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   11
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   367
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   646
      End
      Begin PushButton BetweenBTN
         AutoDeactivate  =   True
         Bold            =   False
         ButtonStyle     =   0
         Cancel          =   False
         Caption         =   "String between substring #1 and substring #2"
         Default         =   False
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   115
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         TabIndex        =   12
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   335
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   333
      End
      Begin CheckBox Inc2CB
         AutoDeactivate  =   True
         Bold            =   False
         Caption         =   "Include substring #2 in the result"
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   156
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Scope           =   0
         State           =   0
         TabIndex        =   13
         TabPanelIndex   =   1
         TabStop         =   True
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   390
         Transparent     =   False
         Underline       =   False
         Value           =   False
         Visible         =   True
         Width           =   646
      End
      Begin Label Label5
         AutoDeactivate  =   True
         Bold            =   False
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Height          =   20
         HelpTag         =   ""
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   12
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Multiline       =   False
         Scope           =   0
         Selectable      =   False
         TabIndex        =   14
         TabPanelIndex   =   1
         TabStop         =   True
         TextAlign       =   0
         TextColor       =   &c000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   432
         Transparent     =   False
         Underline       =   False
         Value           =   "Result:"
         Visible         =   True
         Width           =   52
      End
      Begin TextArea ResultTA
         AcceptTabs      =   False
         Alignment       =   0
         AutoDeactivate  =   True
         AutomaticallyCheckSpelling=   True
         BackColor       =   &cFFFFFF00
         Bold            =   False
         Border          =   True
         DataField       =   ""
         DataSource      =   ""
         Enabled         =   True
         Format          =   ""
         Height          =   98
         HelpTag         =   ""
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "TabPanel1"
         Italic          =   False
         Left            =   115
         LimitText       =   0
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   False
         LockTop         =   True
         Mask            =   ""
         Multiline       =   True
         ReadOnly        =   False
         Scope           =   0
         ScrollbarHorizontal=   False
         ScrollbarVertical=   True
         Styled          =   True
         TabIndex        =   15
         TabPanelIndex   =   1
         TabStop         =   True
         TextColor       =   &c000000
         TextFont        =   "System"
         TextSize        =   0.0
         TextUnit        =   0
         Top             =   428
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   0
         UseFocusRing    =   True
         Value           =   ""
         Visible         =   True
         Width           =   884
      End
   End
End
#tag EndWindow

#tag WindowCode
	#tag Constant, Name = kPresets, Type = String, Dynamic = False, Default = \"src\x3D\"name\x3DEthernet0\"\\rs1\x3D\"name\x3D\"\\rs2\x3D\"\"\\rAction\x3D\"After\"\rsrc\x3D\"name\x3DEthernet0 (full duplex)\"\\rs1\x3D\"name\x3D\"\\rs2\x3D\"(\"\\rAction\x3D\"Between\"", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events BeforeBTN
	#tag Event
		Sub Action()
		  
		  ResultTA.AppendText   SrcTA.Text.StringBefore( substrTA1.Text, BeforeCB.Value ) + EndOfLine
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events AfterBTN
	#tag Event
		Sub Action()
		  
		  ResultTA.AppendText   SrcTA.Text.StringAfter( substrTA1.Text, AfterCB.Value ) + EndOfLine
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events BetweenBTN
	#tag Event
		Sub Action()
		  
		  ResultTA.AppendText   SrcTA.Text.StringBetween( SubstrTA1.Text, SubstrTA2.Text, Inc1CB.Value, Inc2CB.Value ) + EndOfLine
		End Sub
	#tag EndEvent
#tag EndEvents

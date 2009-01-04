#tag Module
Module WindowManager
	#tag Method, Flags = &h0
		Function IsModified(extends w as Window) As Boolean
		  #if targetMacOS
		    soft declare function IsWindowModified lib CarbonFramework (w as WindowPtr) as Boolean
		    
		    return IsWindowModified(w)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsModified(extends w as Window, assigns value as Boolean)
		  #if targetMacOS
		    soft declare function SetWindowModified lib CarbonFramework (w as WindowPtr, modified as Boolean) as Integer
		    
		    dim OSError as Integer = SetWindowModified(w, value)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsCollapsible(extends w as Window) As Boolean
		  #if targetMacOS
		    soft declare function IsWindowCollapsable lib CarbonFramework (window as WindowPtr) as Boolean
		    
		    return IsWindowCollapsable(w)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IsCollapsed(extends w as Window, assigns theValue as Boolean)
		  #if TargetMacOS
		    soft declare function CollapseWindow lib CarbonFramework (window as WindowPtr, collapse as Boolean) as Integer
		    
		    dim OSError as Integer = CollapseWindow(w, theValue)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsCollapsed(extends w as Window) As Boolean
		  #if TargetMacOS
		    soft declare function IsWindowCollapsed lib CarbonFramework (window as WindowPtr) as Boolean
		    
		    return IsWindowCollapsed(w)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CollapseAllWindows(collapse as Boolean)
		  #if targetMacOS
		    soft declare function carbonCollapseAllWindows lib CarbonFramework alias "CollapseAllWindows" (collapse as Boolean) as Integer
		    
		    dim OSError as Integer = carbonCollapseAllWindows(collapse)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CollapseAll()
		  CollapseAllWindows true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShowAll()
		  CollapseAllWindows false
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UpdateDockTile(extends w as Window)
		  #if targetMacOS
		    soft declare function UpdateCollapsedWindowDockTile lib CarbonFramework (inWindow as WindowPtr) as Integer
		    
		    If w.IsCollapsed then
		      dim OSError as Integer = UpdateCollapsedWindowDockTile(w)
		    end if
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Alpha(extends w as Window, assigns value as Single)
		  if value < 0 or value > 1 then
		    return
		  end if
		  
		  #if targetCarbon
		    soft declare function SetWindowAlpha lib CarbonFramework (inWindow as WindowPtr, inAlpha as Single) as Integer
		    
		    dim OSError as Integer = SetWindowAlpha(w, value)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Alpha(extends w as Window) As Single
		  #if targetCarbon
		    soft declare function GetWindowAlpha lib CarbonFramework (inWindow as WindowPtr, ByRef inAlpha as Single) as Integer
		    
		    dim alphaValue as Single
		    dim OSError as Integer = GetWindowAlpha(w, alphaValue)
		    if OSError = 0 then
		      return alphaValue
		    else
		      return 0
		    end if
		  #endif
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Slide(extends w as Window, newLeft as Integer, newTop as Integer)
		  #if TargetMacOS
		    soft declare function GetWindowBounds lib CarbonFramework (window as WindowPtr, regionCode as UInt16, ByRef globalBounds as MacRect) as Integer
		    
		    dim bounds as MacRect
		    dim OSError as Integer = GetWindowBounds(w, kWindowStructureRgn, bounds)
		    if OSError <> 0 then
		      return
		    end if
		    
		    soft declare function TransitionWindow lib CarbonFramework (inWindow as WindowPtr, inEffect as UInt32, inAction as UInt32, ByRef inRect as MacRect) as Integer
		    
		    bounds.top = bounds.top + (newTop- w.Top)
		    bounds.left = bounds.left + (newLeft - w.Left)
		    bounds.bottom = bounds.bottom + (newTop - w.Top)
		    bounds.right = bounds.right + (newLeft - w.Left)
		    OSError = TransitionWindow(w, kWindowSlideTransitionEffect, kWindowMoveTransitionAction, bounds)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SlideResize(extends w as Window, newWidth as Integer, newHeight as Integer)
		  #if TargetMacOS
		    soft declare function GetWindowBounds lib CarbonFramework (window as WindowPtr, regionCode as UInt16, ByRef globalBounds as MacRect) as Integer
		    
		    dim bounds as MacRect
		    dim OSError as Integer = GetWindowBounds(w, kWindowStructureRgn, bounds)
		    if OSError <> 0 then
		      return
		    end if
		    
		    soft declare function TransitionWindow lib CarbonFramework (inWindow as WindowPtr, inEffect as UInt32, inAction as UInt32, ByRef inRect as MacRect) as Integer
		    
		    bounds.bottom = bounds.bottom + (newHeight - w.Height)
		    bounds.right = bounds.right + (newWidth - w.Width)
		    OSError = TransitionWindow(w, kWindowSlideTransitionEffect, kWindowResizeTransitionAction, bounds)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DocumentFile(extends w as Window, assigns f as FolderItem)
		  if f is nil then
		    soft declare function RemoveWindowProxy lib CarbonFramework (inWindow as WindowPtr) as Integer
		    
		    dim OSError as Integer = RemoveWindowProxy(w)
		  else
		    soft declare function FSNewAlias lib CarbonFramework (fromFile as Ptr, ByRef target as FSRef, ByRef inAlias as Ptr) as Short
		    
		    dim aliasHandle as Ptr
		    dim fileRef as FSRef = FileManager.GetFSRefFromFolderItem(f)
		    dim OSError as Integer = FSNewAlias(nil, fileRef, aliasHandle)
		    if OSError <> 0 then
		      return
		    end if
		    
		    soft declare function SetWindowProxyAlias lib CarbonFramework (inWindow as WindowPtr, inAlias as Ptr) as Integer
		    
		    OSError = SetWindowProxyAlias(w, aliasHandle)
		    if aliasHandle <> nil then
		      soft declare sub DisposeHandle lib CarbonFramework (h as Ptr)
		      DisposeHandle aliasHandle
		      aliasHandle = nil
		    end if
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DocumentFile(extends w as Window) As FolderItem
		  #if targetMacOS
		    soft declare function GetWindowProxyAlias lib CarbonFramework (inWindow as WindowPtr, ByRef alias as Ptr) as Integer
		    
		    dim theAlias as Ptr
		    dim OSError as Integer = GetWindowProxyAlias(w, theAlias)
		    if OSError <> 0 then
		      return nil
		    end if
		    
		    soft declare function FSResolveAlias lib CarbonFramework (fromFile as Ptr, alias as Ptr, ByRef Target as FSRef, Byref wasChanged as Boolean) as Int16
		    
		    dim fileRef as FSRef
		    dim wasChanged as Boolean
		    OSError = FSResolveAlias(nil, theAlias, fileRef, wasChanged)
		    if theAlias <> nil then
		      soft declare sub DisposeHandle lib CarbonFramework (h as Ptr)
		      
		      DisposeHandle theAlias
		    end if
		    if OSError = 0 then
		      return FileManager.GetFolderItemFromFSRef(fileRef)
		    else
		      return nil
		    end if
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SendBehind(extends w as Window, behindWindow as Window)
		  if behindWindow is nil then
		    return
		  end if
		  
		  #if targetMacOS
		    soft declare sub SendBehind lib CarbonFramework (window as WindowPtr, behindWindow as WindowPtr)
		    
		    SendBehind w, behindWindow
		  #endif
		End Sub
	#tag EndMethod


	#tag Note, Name = About
		This is part of the open source "MacOSLib"
		
		Original sources are located here:  http://code.google.com/p/macoslib
		
	#tag EndNote


	#tag Constant, Name = kWindowMoveTransitionAction, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kWindowShowTransitionAction, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kWindowHideTransitionAction, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kWindowResizeTransitionAction, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kWindowZoomTransitionEffect, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowSheetTransitionEffect, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowSlideTransitionEffect, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowFadeTransitionEffect, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowGenieTransitionEffect, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowTitleBarRgn, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowTitleTextRgn, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowCloseBoxRgn, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowZoomBoxRgn, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowDragRgn, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowGrowRgn, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowCollapseBoxRgn, Type = Double, Dynamic = False, Default = \"7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowTitleProxyIconRgn, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowStructureRgn, Type = Double, Dynamic = False, Default = \"32", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowContentRgn, Type = Double, Dynamic = False, Default = \"33", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowUpdateRgn, Type = Double, Dynamic = False, Default = \"34", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowOpaqueRgn, Type = Double, Dynamic = False, Default = \"35", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowGlobalPortRgn, Type = Double, Dynamic = False, Default = \"40", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowToolbarButtonRgn, Type = Double, Dynamic = False, Default = \"41", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kWindowIgnoreClicksAttribute, Type = Double, Dynamic = False, Default = \"536870912", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kAlertWindowClass, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kAllWindowClasses, Type = Double, Dynamic = False, Default = \"&hffffffff", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kAltPlainWindowClass, Type = Double, Dynamic = False, Default = \"16", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDocumentWindowClass, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDrawerWindowClass, Type = Double, Dynamic = False, Default = \"20", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kFloatingWindowClass, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kHelpWindowClass, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kModalWindowClass, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kMovableAlertWindowClass, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kMovableModalWindowClass, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kOverlayWindowClass, Type = Double, Dynamic = False, Default = \"14", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kPlainWindowClass, Type = Double, Dynamic = False, Default = \"13", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSheetAlertWindowClass, Type = Double, Dynamic = False, Default = \"15", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSheetWindowClass, Type = Double, Dynamic = False, Default = \"11", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kToolbarWindowClass, Type = Double, Dynamic = False, Default = \"12", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kUtilityWindowClass, Type = Double, Dynamic = False, Default = \"8", Scope = Public
	#tag EndConstant


	#tag Structure, Name = RGBColor, Flags = &h0
		red as UInt16
		  green as UInt16
		blue as UInt16
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule

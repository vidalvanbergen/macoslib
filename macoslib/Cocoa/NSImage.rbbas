#tag Class
Class NSImage
Inherits NSObject
	#tag Method, Flags = &h0
		 Shared Function Advanced() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameAdvanced"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function ApplicationIcon() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameApplicationIcon"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Bonjour() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameBonjour"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Caution() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameCaution"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ClassRef() As Ptr
		  #if targetMacOS
		    return Cocoa.NSClassFromString("NSImage")
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function ColorPanel() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameColorPanel"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Computer() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameComputer"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Copy() As NSImage
		  #if targetMacOS
		    declare function copyWithZone lib CocoaLib selector "copyWithZone:" (obj_id as Ptr, zone as Ptr) as Ptr
		    
		    return new NSImage(copyWithZone(self, nil))
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function DotMac() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameDotMac"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Everyone() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameEveryone"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Folder() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameFolder"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function FolderBurnable() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameFolderBurnable"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function FolderSmart() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameFolderSmart"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function FontPanel() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameFontPanel"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Info() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameInfo"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function LoadByName(name as CFStringRef) As NSImage
		  #if targetMacOS
		    declare function imageNamed lib CocoaLib selector "imageNamed:" (class_id as Ptr, name as CFStringRef) as Ptr
		    
		    dim p as Ptr = imageNamed(ClassRef, name)
		    if p <> nil then
		      return new NSImage(p)
		    else
		      return nil
		    end if
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function LoadByName(name as String) As NSImage
		  dim cfName as CFStringRef = name
		  return LoadByName(cfName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MakeCGImage() As CGImage
		  #if targetMacOS
		    declare function CGImageForProposedRect lib CocoaLib selector "CGImageForProposedRect:context:hints:" (obj_id as Ptr, proposedDestRect as Ptr, referenceContext as Ptr, hints as Ptr) as Ptr
		    
		    dim imagePtr as Ptr = CGImageForProposedRect(self, nil, nil, nil)
		    if imagePtr <> nil then
		      return new CGImage(imagePtr, not CFType.hasOwnership)
		    else
		      return nil
		    end if
		  #endif
		  
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function MobileMe() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameMobileMe"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function MultipleDocuments() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameMultipleDocuments"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Network() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameNetwork"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function PreferencesGeneral() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNamePreferencesGeneral"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function ResolveSymbol(symbolName as String) As CFStringRef
		  dim b as CFBundle = CFBundle.NewCFBundleFromID(Cocoa.BundleID)
		  if b <> nil then
		    return b.StringPointerRetained(symbolName)
		    
		  else
		    return nil
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Size() As Cocoa.NSSize
		  #if targetMacOS
		    declare function size lib CocoaLib selector "size" (obj_id as Ptr) as Cocoa.NSSize
		    
		    return size(self)
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Size(assigns value as Cocoa.NSSize)
		  //starting in MacOS 10.6, this rescales the image.
		  
		  #if targetMacOS
		    declare sub setSize lib CocoaLib selector "setSize:" (obj_id as Ptr, value as Cocoa.NSSize)
		    
		    setSize(self, value)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function StatusAvailable() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameStatusAvailable"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function StatusNone() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameStatusNone"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function StatusPartiallyAvailable() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameStatusPartiallyAvailable"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function StatusUnavailable() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameStatusUnavailable"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function TrashEmpty() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameTrashEmpty"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function TrashFull() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameTrashFull"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function User() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameUser"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function UserAccounts() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameUserAccounts"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function UserGroup() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameUserGroup"))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function UserGuest() As NSImage
		  return LoadByName(ResolveSymbol("NSImageNameUserGuest"))
		End Function
	#tag EndMethod


	#tag Note, Name = Conversion from Picture
		To create an NSimage from a REALbasic Picture, create a CGImage from the Picture, then make an NSImage.
		
		  dim p as new Picture(32, 32, 32)
		  p.Graphics.ForeColor = &cff0000
		  p.Graphics.FillRect 0, 0, p.Width, p.Height
		  
		  dim cg_image as CGImage = CGImage.NewCGImage(p)
		  dim nsimage as NSImage = cg_image.MakeNSImage
	#tag EndNote

	#tag Note, Name = Conversion to Picture
		Given an NSImage, you can convert it to a REALbasic Picture object by first converting to a CGimage, then to a Picture.
		
		dim cg_image as CGImage = image.MakeCGImage
		dim p as Picture = cg_image.MakePicture
	#tag EndNote


	#tag ViewBehavior
		#tag ViewProperty
			Name="Description"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="NSObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
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
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
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
End Class
#tag EndClass

#tag Class
Protected Class ICDevice
Inherits NSObject
	#tag Method, Flags = &h0
		Function ButtonPressed() As String
		  #if TargetMacOS
		    declare function buttonPressed lib ICLib selector "buttonPressed" (id as Ptr) as CFStringRef
		    
		    return  buttonPressed( me.id )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Capabilities() As NSArray
		  #if TargetMacOS
		    declare function capabilities lib ICLib selector "capabilities" (id as Ptr) as Ptr
		    
		    return  new NSArray( capabilities( me.id ), false )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CloseSession()
		  #if TargetMacOS
		    declare sub requestCloseSession lib ICLib selector "requestCloseSession" (id as Ptr)
		    
		    requestCloseSession  me.id
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function CocoaDelegateMap() As Dictionary
		  static d as new Dictionary
		  return d
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1021
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(id as Ptr, hasOwnership as boolean = false)
		  Super.Constructor id, hasOwnership
		  
		  //ICDevices are instantiated by the ICDeviceBrowser so we need to set the delegate here
		  if GetDelegate = nil then
		    SetDelegate
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function DelegateClassID() As Ptr
		  static p as Ptr = MakeDelegateClass
		  return p
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub delegate_DeviceDidChangeName(id as Ptr, sel as Ptr, sender as Ptr)
		  #pragma unused sender
		  #pragma unused sel
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey( id ) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup( id, new WeakRef( nil ))
		    dim obj as ICDevice = ICDevice( w.Value )
		    if obj <> nil then
		      obj.Handle_ChangedName
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub delegate_DeviceDidChangeSharingState(id as Ptr, sel as Ptr, sender as Ptr)
		  #pragma unused sender
		  #pragma unused sel
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey( id ) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup( id, new WeakRef( nil ))
		    dim obj as ICDevice = ICDevice( w.Value )
		    if obj <> nil then
		      obj.Handle_ChangedSharingState
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub delegate_DeviceDidEncounterError(id as Ptr, sel as Ptr, sender as Ptr, error as Ptr)
		  #pragma unused sender
		  #pragma unused sel
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey( id ) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup( id, new WeakRef( nil ))
		    dim obj as ICDevice = ICDevice( w.Value )
		    if obj <> nil then
		      obj.Handle_Error   error
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub delegate_DeviceDidReceiveButtonPress(id as Ptr, sel as Ptr, sender as Ptr, button as CFStringRef)
		  #pragma unused sender
		  #pragma unused sel
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey( id ) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup( id, new WeakRef( nil ))
		    dim obj as ICDevice = ICDevice( w.Value )
		    if obj <> nil then
		      obj.Handle_ButtonPressed   button
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub delegate_DeviceDidReceiveCustomNotification(id as Ptr, sel as Ptr, sender as Ptr, notification as Ptr, data as Ptr)
		  #pragma unused id
		  #pragma unused sel
		  #pragma unused sender
		  #pragma unused notification
		  #pragma unused data
		  
		  #pragma stackOverflowChecking false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub delegate_DeviceDidReceiveStatusInformation(id as Ptr, sel as Ptr, sender as Ptr, status as Ptr)
		  #pragma unused sender
		  #pragma unused sel
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey( id ) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup( id, new WeakRef( nil ))
		    dim obj as ICDevice = ICDevice( w.Value )
		    if obj <> nil then
		      obj.Handle_StatusNotification   status
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub delegate_DidBecomeReady(id as Ptr, sel as Ptr, sender as Ptr)
		  #pragma unused sender
		  #pragma unused sel
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey( id ) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup( id, new WeakRef( nil ))
		    dim obj as ICDevice = ICDevice( w.Value )
		    if obj <> nil then
		      obj.Handle_DeviceReady
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub delegate_DidCloseSessionWithError(id as Ptr, sel as Ptr, sender as Ptr, error as Ptr)
		  #pragma unused sender
		  #pragma unused sel
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey( id ) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup( id, new WeakRef( nil ))
		    dim obj as ICDevice = ICDevice( w.Value )
		    if obj <> nil then
		      obj.Handle_DidCloseSession   error
		      
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub delegate_DidOpenSessionWithError(id as Ptr, sel as Ptr, sender as Ptr, error as Ptr)
		  #pragma unused sender
		  #pragma unused sel
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey( id ) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup( id, new WeakRef( nil ))
		    dim obj as ICDevice = ICDevice( w.Value )
		    if obj <> nil then
		      obj.Handle_DidOpenSession   error
		      
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub delegate_DidRemoveDevice(id as Ptr, sel as Ptr, sender as Ptr)
		  #pragma unused sender
		  #pragma unused sel
		  #pragma stackOverflowChecking false
		  
		  if CocoaDelegateMap.HasKey( id ) then
		    dim w as WeakRef = CocoaDelegateMap.Lookup( id, new WeakRef( nil ))
		    dim obj as ICDevice = ICDevice( w.Value )
		    if obj <> nil then
		      obj.Handle_DidRemoveDevice
		      
		    else
		      //something might be wrong.
		    end if
		  else
		    //something might be wrong.
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  //# Per ICDevice.h "Therefore the delegate property of the ICDevice instance must be set to NULL before the delegate is released"
		  
		  #if TargetMacOS
		    declare sub setDelegate lib CocoaLib selector "setDelegate:" (obj_id as Ptr, del_id as Ptr)
		    
		    dim del_id as Ptr = me.GetDelegate
		    
		    SetDelegate( me.id, nil )
		    
		    if del_id<>nil then
		      Cocoa.Release( del_id )
		    end if
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub EjectOrDisconnect()
		  #if TargetMacOS
		    declare sub requestEjectOrDisconnect lib ICLib selector "requestEjectOrDisconnect" (id as Ptr)
		    
		    requestEjectOrDisconnect  me.id
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function FPtr(p as Ptr) As Ptr
		  //This function is a workaround for the inability to convert a Variant containing a delegate to Ptr:
		  //dim v as Variant = AddressOf Foo
		  //dim p as Ptr = v
		  //results in a TypeMismatchException
		  //So now I do
		  //dim v as Variant = FPtr(AddressOf Foo)
		  //dim p as Ptr = v
		  
		  return p
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDelegate() As Ptr
		  #if targetMacOS
		    declare function m_delegate lib CocoaLib selector "delegate" (obj_id as Ptr) as Ptr
		    
		    return  m_delegate( me.id )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Handle_ButtonPressed(button as String)
		  'RaiseEvent  ButtonPressed( button )
		  
		  #pragma unused button
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Handle_ChangedName()
		  'RaiseEvent  ChangedName
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Handle_ChangedSharingState()
		  'RaiseEvent  ChangedSharingState
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Handle_DeviceReady()
		  'RaiseEvent   DeviceReady
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Handle_DidCloseSession(err as Ptr)
		  '
		  'dim error as NSException
		  'if err<>nil then
		  'error = new NSException( err )
		  'end if
		  '
		  'RaiseEvent  SessionClosed( error )
		  
		  #pragma unused err
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Handle_DidOpenSession(err as Ptr)
		  '
		  'dim error as NSException
		  'if err<>nil then
		  'error = new NSException( err )
		  'end if
		  '
		  'RaiseEvent  SessionOpened( error )
		  
		  #pragma unused err
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Handle_DidRemoveDevice()
		  'RaiseEvent   DeviceRemoved
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Handle_Error(err as Ptr)
		  '
		  'RaiseEvent   Error( new NSException( err ))
		  
		  #pragma unused err
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Handle_StatusNotification(status as Ptr)
		  'RaiseEvent   StatusNotification ( new NSDictionary( status, false ))
		  
		  #pragma unused status
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasConfigurableWiFiInterface() As boolean
		  #if TargetMacOS
		    declare function hasConfigurableWiFiInterface lib ICLib selector "hasConfigurableWiFiInterface" (id as Ptr) as boolean
		    
		    return  hasConfigurableWiFiInterface( me.id )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasOpenSession() As boolean
		  #if TargetMacOS
		    declare function hasOpenSession lib ICLib selector "hasOpenSession" (id as Ptr) as boolean
		    
		    return  hasOpenSession( me.id )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Icon() As CGImage
		  #if TargetMacOS
		    declare function icon lib ICLib selector "icon" (id as Ptr) as Ptr
		    
		    return  new CGImage( icon( me.id ), false )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsRemote() As boolean
		  #if TargetMacOS
		    declare function IsRemote lib ICLib selector "IsRemote" (id as Ptr) as boolean
		    
		    return  IsRemote( me.id )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsShared() As boolean
		  #if TargetMacOS
		    declare function IsShared lib ICLib selector "IsShared" (id as Ptr) as boolean
		    
		    return  IsShared( me.id )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LocationDescription() As String
		  #if TargetMacOS
		    declare function locationDescription lib ICLib selector "locationDescription" (id as Ptr) as CFStringRef
		    
		    return  locationDescription( me.id )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function MakeDelegateClass(className as String = DelegateClassName, superclassName as String = "NSObject") As Ptr
		  #pragma unused className
		  #pragma unused superClassName
		  
		  #if false //Not fully implemented yet
		    '//this is Objective-C 2.0 code (available in Leopard).  For 1.0, we'd need to do it differently.
		    '
		    '#if targetCocoa
		    'declare function objc_allocateClassPair lib CocoaLib (superclass as Ptr, name as CString, extraBytes as Integer) as Ptr
		    'declare sub objc_registerClassPair lib CocoaLib (cls as Ptr)
		    'declare function class_addMethod lib CocoaLib (cls as Ptr, name as Ptr, imp as Ptr, types as CString) as Boolean
		    '
		    'dim newClassId as Ptr = objc_allocateClassPair(Cocoa.NSClassFromString(superclassName), className, 0)
		    'if newClassId = nil then
		    'raise new macoslibException( "Unable to create ObjC subclass " + className + " from " + superclassName ) //perhaps the class already exists.  We could check for this, and raise an exception for other errors.
		    'return nil
		    'end if
		    '
		    'objc_registerClassPair newClassId
		    '
		    'dim methodList() as Tuple
		    'methodList.Append  "didRemoveDevice:" : FPtr( AddressOf  delegate_DidRemoveDevice ) : "v@:@"
		    'methodList.Append  "device:didOpenSessionWithError:" : FPtr( AddressOf  delegate_DidOpenSessionWithError ) : "v@:@@"
		    'methodList.Append  "deviceDidBecomeReady:" : FPtr( AddressOf  delegate_DidBecomeReady ) : "v@:@"
		    'methodList.Append  "device:didCloseSessionWithError:" : FPtr( AddressOf  delegate_DidCloseSessionWithError ) : "v@:@@"
		    'methodList.Append  "deviceDidChangeName:" : FPtr( AddressOf delegate_DeviceDidChangeName ) : "v@:@"
		    'methodList.Append  "deviceDidChangeSharingState:" : FPtr ( AddressOf delegate_DeviceDidChangeSharingState ) : "v@:@"
		    'methodList.Append  "device:didReceiveStatusInformation:" : FPtr( AddressOf delegate_DeviceDidReceiveStatusInformation ) : "v@:@@"
		    'methodList.Append  "device:didEncounterError:" : FPtr( AddressOf delegate_DeviceDidEncounterError ) : "v@:@@"
		    'methodList.Append  "device:didReceiveButtonPress:" : FPtr( AddressOf delegate_DeviceDidReceiveButtonPress ) : "v@:@@"
		    'methodList.Append  "device:didReceiveCustomNotification:data:" : FPtr( AddressOf delegate_DeviceDidReceiveCustomNotification ) : "v@:@@@"
		    '
		    'dim methodsAdded as Boolean = true
		    'for each item as Tuple in methodList
		    'methodsAdded = methodsAdded and class_addMethod(newClassId, Cocoa.NSSelectorFromString(item(0)), item(1), item(2))
		    'next
		    '
		    'if methodsAdded then
		    'return newClassId
		    'else
		    'return nil
		    'end if
		    '
		    '#else
		    '#pragma unused className
		    '#pragma unused superClassName
		    '#endif
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name() As String
		  #if TargetMacOS
		    declare function name lib ICLib selector "name" (id as Ptr) as CFStringRef
		    
		    return  name( me.id )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OpenSession()
		  #if TargetMacOS
		    declare sub requestOpenSession lib ICLib selector "requestOpenSession" (id as Ptr)
		    
		    requestOpenSession  me.id
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PersistentIDString() As String
		  #if TargetMacOS
		    declare function persistentIDString lib ICLib selector "persistentIDString" (id as Ptr) as CFStringRef
		    
		    return  persistentIDString( me.id )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function serialNumberString() As String
		  #if TargetMacOS
		    declare function serialNumberString lib ICLib selector "serialNumberString" (id as Ptr) as CFStringRef
		    
		    return  serialNumberString( me.id )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetDelegate()
		  #if targetCocoa
		    declare function alloc lib CocoaLib selector "alloc" (class_id as Ptr) as Ptr
		    declare function init lib CocoaLib selector "init" (obj_id as Ptr) as Ptr
		    declare sub setDelegate lib CocoaLib selector "setDelegate:" (obj_id as Ptr, del_id as Ptr)
		    
		    
		    dim delegate_id as Ptr = init(alloc(DelegateClassID))
		    if delegate_id = nil then
		      return
		    end if
		    setDelegate self, delegate_id
		    CocoaDelegateMap.Value(delegate_id) = new WeakRef(self)
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function transportType() As String
		  #if TargetMacOS
		    declare function transportType lib ICLib selector "transportType" (id as Ptr) as CFStringRef
		    
		    return  transportType( me.id )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserData() As NSMutableDictionary
		  #if TargetMacOS
		    declare function userData lib ICLib selector "userData" (id as Ptr) as Ptr
		    
		    return  new NSMutableDictionary( userData( me.id ), false )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UUIDString() As String
		  #if TargetMacOS
		    declare function UUIDString lib ICLib selector "UUIDString" (id as Ptr) as CFStringRef
		    
		    return  UUIDString( me.id )
		  #endif
		End Function
	#tag EndMethod


	#tag Constant, Name = DelegateClassName, Type = String, Dynamic = False, Default = \"ICDeviceDelegate", Scope = Private
	#tag EndConstant

	#tag Constant, Name = NSClassName, Type = String, Dynamic = False, Default = \"ICDevice", Scope = Private
	#tag EndConstant


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

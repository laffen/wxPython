/////////////////////////////////////////////////////////////////////////////
// Name:        _window.i
// Purpose:     SWIG interface for wxWindow
//
// Author:      Robin Dunn
//
// Created:     24-June-1997
// RCS-ID:      $Id$
// Copyright:   (c) 2003 by Total Control Software
// Licence:     wxWindows license
/////////////////////////////////////////////////////////////////////////////

// Not a %module


//---------------------------------------------------------------------------

%{
%}

MAKE_CONST_WXSTRING(PanelNameStr);

//---------------------------------------------------------------------------
%newgroup

class wxWindow : public wxEvtHandler
{
public:
    %addtofunc wxWindow         "self._setOORInfo(self)"
    %addtofunc wxWindow()       ""

    wxWindow(wxWindow* parent, const wxWindowID id,
             const wxPoint& pos = wxDefaultPosition,
             const wxSize& size = wxDefaultSize,
             long style = 0,
             const wxString& name = wxPyPanelNameStr);
    %name(PreWindow)wxWindow();

    bool Create(wxWindow* parent, const wxWindowID id,
                const wxPoint& pos = wxDefaultPosition,
                const wxSize& size = wxDefaultSize,
                long style = 0,
                const wxString& name = wxPyPanelNameStr);



    // deleting the window
    // -------------------

    // ask the window to close itself, return True if the event handler
    // honoured our request
    bool Close( bool force = False );

    // delete window unconditionally (dangerous!), returns True if ok
    virtual bool Destroy();

    // delete all children of this window, returns True if ok
    bool DestroyChildren();

    // is the window being deleted?
    bool IsBeingDeleted() const;


    // window attributes
    // -----------------

    // the text which the window shows in the title if applicable
    virtual void SetTitle( const wxString& WXUNUSED(title) );
    virtual wxString GetTitle() const;

    // the text which the window shows in its label if applicable
    virtual void SetLabel(const wxString& label);
    virtual wxString GetLabel() const;

    // the window name is used for ressource setting in X, it is not the
    // same as the window title/label
    virtual void SetName( const wxString &name );
    virtual wxString GetName() const;

    // window id uniquely identifies the window among its siblings unless
    // it is -1 which means "don't care"
    void SetId( wxWindowID winid );
    wxWindowID GetId() const;

    // generate a control id for the controls which were not given one by
    // user
    static int NewControlId();

    // get the id of the control following the one with the given
    // (autogenerated) id
    static int NextControlId(int winid);

    // get the id of the control preceding the one with the given
    // (autogenerated) id
    static int PrevControlId(int winid);



    // moving/resizing
    // ---------------

    // set the window size
    void SetSize( const wxSize& size );

    // set the window size and position
    %name(SetDimensions) void SetSize( int x, int y, int width, int height,
                                       int sizeFlags = wxSIZE_AUTO );

    // set the window size and position with a wxRect
    %name(SetRect) void SetSize(const wxRect& rect, int sizeFlags = wxSIZE_AUTO);

    // set window size
    %name(SetSizeWH)void SetSize( int width, int height );

    // set window position
    void Move(const wxPoint& pt, int flags = wxSIZE_USE_EXISTING);
    %pythoncode { SetPosition = Move }

    // set window position
    %name(MoveXY) void Move(int x, int y, int flags = wxSIZE_USE_EXISTING);

    // Z-order
    virtual void Raise();
    virtual void Lower();

    // client size is the size of the area available for subwindows
    void SetClientSize( const wxSize& size );
    %name(SetClientSizeWH) void SetClientSize( int width, int height );
    %name(SetClientRect) void SetClientSize(const wxRect& rect);


    DocStr(GetPosition,   // sets the docstring for both
           "Get the window's position.");
    wxPoint GetPosition();

    DocDeclAName(
        void, GetPosition(int *OUTPUT, int *OUTPUT),
        "GetPositionTuple() -> (x,y)",
        GetPositionTuple);

   
    DocStr(GetSize, "Get the window size.");
    wxSize GetSize() const;
    DocDeclAName(
        void, GetSize( int *OUTPUT, int *OUTPUT ) const,
        "GetSizeTuple() -> (width, height)",
        GetSizeTuple);
    
    
    // get the window position and size
    wxRect GetRect() const;

    DocStr(GetClientSize, "Get the window's client size.");
    wxSize GetClientSize() const;
    DocDeclAName(
        void, GetClientSize( int *OUTPUT, int *OUTPUT ) const,
        "GetClientSizeTuple() -> (width, height)",
        GetClientSizeTuple);


    // get the origin of the client area of the window relative to the
    // window top left corner (the client area may be shifted because of
    // the borders, scrollbars, other decorations...)
    virtual wxPoint GetClientAreaOrigin() const;

    // get the client rectangle in window (i.e. client) coordinates
    wxRect GetClientRect() const;

    DocStr(GetBestSize,
           "Get the size best suited for the window (in fact, minimal acceptable size\n"
           "using which it will still look \"nice\")");
    wxSize GetBestSize() const;
    DocDeclAName(
        void, GetBestSize(int *OUTPUT, int *OUTPUT) const,
        "GetBestSizeTuple() -> (width, height)",
        GetBestSizeTuple);
    

    // There are times (and windows) where 'Best' size and 'Min' size
    // are vastly out of sync.  This should be remedied somehow, but in
    // the meantime, this method will return the larger of BestSize
    // (the window's smallest legible size), and any user specified
    // MinSize hint.
    wxSize GetAdjustedBestSize() const;


    // the generic center function - centers the window on parent by
    // default or on screen if it doesn't have parent or
    // wxCENTER_ON_SCREEN flag is given
    void Center( int direction = wxBOTH );
    %pythoncode { Centre = Center }

    // center on screen (only works for top level windows)
    void CenterOnScreen(int dir = wxBOTH);
    %pythoncode { CentreOnScreen = CenterOnScreen }

    // center with respect to the the parent window
    void CenterOnParent(int dir = wxBOTH);
    %pythoncode { CentreOnParent = CenterOnParent }


    // set window size to wrap around its children
    virtual void Fit();

    // set virtual size to satisfy children
    virtual void FitInside();

    // set min/max size of the window
    virtual void SetSizeHints( int minW, int minH,
                               int maxW = -1, int maxH = -1,
                               int incW = -1, int incH = -1 );

    virtual void SetVirtualSizeHints( int minW, int minH,
                                      int maxW = -1, int maxH = -1 );

    virtual int GetMinWidth() const;
    virtual int GetMinHeight() const;
    int GetMaxWidth() const;
    int GetMaxHeight() const;


    // Override this method to control the values given to Sizers etc.
    virtual wxSize GetMaxSize() const;

    
    DocStr(SetVirtualSize,
           "Set the the virtual size of a window.  For most windows this is just the\n"
           "client area of the window, but for some like scrolled windows it is more or\n"
           "less independent of the screen window size.");
    void SetVirtualSize(const wxSize& size );
    %name(SetVirtualSizeWH) void SetVirtualSize( int w, int h );

    
    DocStr(GetVirtualSize,
           "Get the the virtual size of the window.  For most windows this is just\n" 
           "the client area of the window, but for some like scrolled windows it is\n"
           "more or less independent of the screen window size.");           
    wxSize GetVirtualSize() const;
    DocDeclAName(
        void, GetVirtualSize( int *OUTPUT, int *OUTPUT ) const,
        "GetVirtualSizeTuple() -> (width, height)",
        GetVirtualSizeTuple);


// TODO: using directors?
//     // Override these methods for windows that have a virtual size
//     // independent of their client size.  eg. the virtual area of a
//     // wxScrolledWindow.  Default is to alias VirtualSize to ClientSize.
//     virtual void DoSetVirtualSize( int x, int y );
//     virtual wxSize DoGetVirtualSize() const; // { return m_virtualSize; }


    // Return the largest of ClientSize and BestSize (as determined
    // by a sizer, interior children, or other means)
    virtual wxSize GetBestVirtualSize() const;



    // window state
    // ------------

    // returns True if window was shown/hidden, False if the nothing was
    // done (window was already shown/hidden)
    virtual bool Show( bool show = True );
    bool Hide();

    // returns True if window was enabled/disabled, False if nothing done
    virtual bool Enable( bool enable = True );
    bool Disable();

    bool IsShown() const;
    bool IsEnabled() const;

    // get/set window style (setting style won't update the window and so
    // is only useful for internal usage)
    virtual void SetWindowStyleFlag( long style );
    virtual long GetWindowStyleFlag() const;

    // get/set window style (setting style won't update the window and so
    // is only useful for internal usage)
    void SetWindowStyle( long style );
    long GetWindowStyle() const;

    bool HasFlag(int flag) const;
    virtual bool IsRetained() const;

    // extra style: the less often used style bits which can't be set with
    // SetWindowStyleFlag()
    virtual void SetExtraStyle(long exStyle);
    long GetExtraStyle() const;

    // make the window modal (all other windows unresponsive)
    virtual void MakeModal(bool modal = True);

    virtual void SetThemeEnabled(bool enableTheme);
    virtual bool GetThemeEnabled() const;

    // controls by default inherit the colours of their parents, if a
    // particular control class doesn't want to do it, it can override
    // ShouldInheritColours() to return False
    virtual bool ShouldInheritColours() const;


    // focus and keyboard handling
    // ---------------------------

    // set focus to this window
    virtual void SetFocus();

    // set focus to this window as the result of a keyboard action
    virtual void SetFocusFromKbd();

    // return the window which currently has the focus or NULL
    static wxWindow *FindFocus();

    // can this window have focus?
    virtual bool AcceptsFocus() const;

    // can this window be given focus by keyboard navigation? if not, the
    // only way to give it focus (provided it accepts it at all) is to
    // click it
    virtual bool AcceptsFocusFromKeyboard() const;

    // get the default child of this parent, i.e. the one which is
    // activated by pressing <Enter>
    virtual wxWindow *GetDefaultItem() const;

    // set this child as default, return the old default
    virtual wxWindow *SetDefaultItem(wxWindow * WXUNUSED(child));

    // set this child as temporary default
    virtual void SetTmpDefaultItem(wxWindow * WXUNUSED(win));



    // parent/children relations
    // -------------------------

    // get the list of children
    //wxWindowList& GetChildren();  // TODO: Do a typemap or a wrapper for wxWindowList
    %extend {
        PyObject* GetChildren() {
            wxWindowList& list = self->GetChildren();
            return wxPy_ConvertList(&list);
        }
    }

    // get the parent or the parent of the parent
    wxWindow *GetParent() const;
    wxWindow *GetGrandParent() const;

    // is this window a top level one?
    virtual bool IsTopLevel() const;

    // change the real parent of this window, return True if the parent
    // was changed, False otherwise (error or newParent == oldParent)
    virtual bool Reparent( wxWindow *newParent );

    // implementation mostly
    virtual void AddChild( wxWindow *child );
    virtual void RemoveChild( wxWindow *child );



    // looking for windows
    // -------------------

    // find window among the descendants of this one either by id or by
    // name (return NULL if not found)
    %name(FindWindowById) wxWindow *FindWindow( long winid );
    %name(FindWindowByName) wxWindow *FindWindow( const wxString& name );


    // event handler stuff
    // -------------------

    // get the current event handler
    wxEvtHandler *GetEventHandler() const;

    // replace the event handler (allows to completely subclass the
    // window)
    void SetEventHandler( wxEvtHandler *handler );

    // push/pop event handler: allows to chain a custom event handler to
    // alreasy existing ones
    void PushEventHandler( wxEvtHandler *handler );
    wxEvtHandler *PopEventHandler( bool deleteHandler = False );

    // find the given handler in the event handler chain and remove (but
    // not delete) it from the event handler chain, return True if it was
    // found and False otherwise (this also results in an assert failure so
    // this function should only be called when the handler is supposed to
    // be there)
    bool RemoveEventHandler(wxEvtHandler *handler);



    // validators
    // ----------

    // a window may have an associated validator which is used to control
    // user input
    virtual void SetValidator( const wxValidator &validator );
    virtual wxValidator *GetValidator();


    // accelerators
    // ------------

    virtual void SetAcceleratorTable( const wxAcceleratorTable& accel );
    wxAcceleratorTable *GetAcceleratorTable();




    // hot keys (system wide accelerators)
    // -----------------------------------
    %extend {
        // hot keys (system wide accelerators)
        bool RegisterHotKey(int hotkeyId, int modifiers, int keycode) {
        #if wxUSE_HOTKEY
            return self->RegisterHotKey(hotkeyId, modifiers, keycode);
        #else
            return False;
        #endif
        }

        bool UnregisterHotKey(int hotkeyId) {
        #if wxUSE_HOTKEY
            return self->UnregisterHotKey(hotkeyId);
        #else
            return False;
        #endif
        }
    }



    // "dialog units" translations
    // ---------------------------

    %name(ConvertDialogPointToPixels) wxPoint ConvertDialogToPixels(const wxPoint& pt);
    %name(ConvertDialogSizeToPixels)  wxSize  ConvertDialogToPixels(const wxSize& sz);

    %name(DLG_PNT) wxPoint ConvertDialogToPixels(const wxPoint& pt);
    %name(DLG_SZE) wxSize  ConvertDialogToPixels(const wxSize& sz);

    %name(ConvertPixelPointToDialog) wxPoint ConvertPixelsToDialog(const wxPoint& pt);
    %name(ConvertPixelSizeToDialog)  wxSize  ConvertPixelsToDialog(const wxSize& sz);



    // mouse functions
    // ---------------

    // move the mouse to the specified position
    virtual void WarpPointer(int x, int y);

    // start or end mouse capture, these functions maintain the stack of
    // windows having captured the mouse and after calling ReleaseMouse()
    // the mouse is not released but returns to the window which had had
    // captured it previously (if any)
    void CaptureMouse();
    void ReleaseMouse();

    // get the window which currently captures the mouse or NULL
    static wxWindow *GetCapture();

    // does this window have the capture?
    virtual bool HasCapture() const;



    // painting the window
    // -------------------

    // mark the specified rectangle (or the whole window) as "dirty" so it
    // will be repainted
    virtual void Refresh( bool eraseBackground = True,
                          const wxRect *rect = NULL );

    // a less awkward wrapper for Refresh
    void RefreshRect(const wxRect& rect);

    // repaint all invalid areas of the window immediately
    virtual void Update();

    // clear the window background
    virtual void ClearBackground();

    // freeze the window: don't redraw it until it is thawed
    virtual void Freeze();

    // thaw the window: redraw it after it had been frozen
    virtual void Thaw();

    // adjust DC for drawing on this window
    virtual void PrepareDC( wxDC & WXUNUSED(dc) );

    // the update region of the window contains the areas which must be
    // repainted by the program
    wxRegion& GetUpdateRegion();

    // get the update rectangle region bounding box in client coords
    wxRect GetUpdateClientRect() const;

    // these functions verify whether the given point/rectangle belongs to
    // (or at least intersects with) the update region
    bool IsExposed( int x, int y, int w=1, int h=1 ) const;
    %name(IsExposedPoint) bool IsExposed( const wxPoint& pt ) const;
    %name(isExposedRect)  bool IsExposed( const wxRect& rect ) const;



    // colours, fonts and cursors
    // --------------------------

    // set/retrieve the window colours (system defaults are used by
    // default): Set functions return True if colour was changed
    virtual bool SetBackgroundColour( const wxColour &colour );
    virtual bool SetForegroundColour( const wxColour &colour );

    wxColour GetBackgroundColour() const;
    wxColour GetForegroundColour() const;

    // set/retrieve the cursor for this window (SetCursor() returns True
    // if the cursor was really changed)
    virtual bool SetCursor( const wxCursor &cursor );
    wxCursor& GetCursor();

    // set/retrieve the font for the window (SetFont() returns True if the
    // font really changed)
    virtual bool SetFont( const wxFont &font );
    wxFont& GetFont();

    // associate a caret with the window
    void SetCaret(wxCaret *caret);

    // get the current caret (may be NULL)
    wxCaret *GetCaret() const;

    // get the (average) character size for the current font
    virtual int GetCharHeight() const;
    virtual int GetCharWidth() const;


    DocDeclAStr(
        void, GetTextExtent(const wxString& string, int *OUTPUT, int *OUTPUT),
        "GetTextExtent(String string) -> (width, height)",
        "Get the width and height of the text using the current font.");
    DocDeclAStrName(
        void, GetTextExtent(const wxString& string,
                            int *OUTPUT, int *OUTPUT, int *OUTPUT, int* OUTPUT, 
                            const wxFont* font = NULL),
        "GetFullTextExtent(String string, Font font=None) ->\n   (width, height, descent, externalLeading)",
        "Get the width, height, decent and leading of the text using the current or specified font.",
        GetFullTextExtent);



    // client <-> screen coords
    // ------------------------

    %apply int * INOUT { int* x, int* y };

    // translate to/from screen/client coordinates
    %name(ClientToScreenXY) void ClientToScreen( int *x, int *y ) const;
    %name(ScreenToClientXY) void ScreenToClient( int *x, int *y ) const;

    wxPoint ClientToScreen(const wxPoint& pt) const;
    wxPoint ScreenToClient(const wxPoint& pt) const;

    // test where the given (in client coords) point lies
    %name(HitTestXY) wxHitTest HitTest(wxCoord x, wxCoord y) const;
    wxHitTest HitTest(const wxPoint& pt) const;



    // misc
    // ----

    // get the window border style from the given flags: this is different from
    // simply doing flags & wxBORDER_MASK because it uses GetDefaultBorder() to
    // translate wxBORDER_DEFAULT to something reasonable
     %name(GetBorderFlags) wxBorder GetBorder(long flags) const;

    // get border for the flags of this window
    wxBorder GetBorder() const { return GetBorder(GetWindowStyleFlag()); }

    // send wxUpdateUIEvents to this window, and children if recurse is True
    virtual void UpdateWindowUI(long flags = wxUPDATE_UI_NONE);

// TODO: using directors?
//     // do the window-specific processing after processing the update event
//     virtual void DoUpdateWindowUI(wxUpdateUIEvent& event) ;

    %name(PopupMenuXY) bool PopupMenu(wxMenu *menu, int x, int y);
    bool PopupMenu(wxMenu *menu, const wxPoint& pos);

    %extend {
        long GetHandle() {
            return wxPyGetWinHandle(self);
        }
    }


#ifdef __WXMSW__
    // A way to do the native draw first...  Too bad it isn't in wxGTK too.
    void OnPaint(wxPaintEvent& event);
#endif



    // scrollbars
    // ----------

    // does the window have the scrollbar for this orientation?
    bool HasScrollbar(int orient) const;

    // configure the window scrollbars
    virtual void SetScrollbar( int orient,
                               int pos,
                               int thumbvisible,
                               int range,
                               bool refresh = True );
    virtual void SetScrollPos( int orient, int pos, bool refresh = True );
    virtual int GetScrollPos( int orient ) const;
    virtual int GetScrollThumb( int orient ) const;
    virtual int GetScrollRange( int orient ) const;

    // scroll window to the specified position
    virtual void ScrollWindow( int dx, int dy,
                               const wxRect* rect = NULL );

    // scrolls window by line/page: note that not all controls support this
    //
    // return True if the position changed, False otherwise
    virtual bool ScrollLines(int WXUNUSED(lines));
    virtual bool ScrollPages(int WXUNUSED(pages));

    // convenient wrappers for ScrollLines/Pages
    bool LineUp();
    bool LineDown();
    bool PageUp();
    bool PageDown();



    // context-sensitive help
    // ----------------------

    // associate this help text with this window
    void SetHelpText(const wxString& text);

    // associate this help text with all windows with the same id as this
    // one
    void SetHelpTextForId(const wxString& text);

    // get the help string associated with this window (may be empty)
    wxString GetHelpText() const;


#ifndef __WXX11__
    // tooltips
    // --------

    // the easiest way to set a tooltip for a window is to use this method
    %name(SetToolTipString) void SetToolTip( const wxString &tip );

    // attach a tooltip to the window
    void SetToolTip( wxToolTip *tip );

    // get the associated tooltip or NULL if none
    wxToolTip* GetToolTip() const;
    // LINK ERROR --> wxString GetToolTipText() const;
#endif


    
#ifndef __WXX11__
    // drag and drop
    // -------------

    // set/retrieve the drop target associated with this window (may be
    // NULL; it's owned by the window and will be deleted by it)
    %apply SWIGTYPE *DISOWN { wxPyDropTarget *dropTarget };
    virtual void SetDropTarget( wxPyDropTarget *dropTarget );
    %clear wxPyDropTarget *dropTarget;
    
    virtual wxPyDropTarget *GetDropTarget() const;

#ifdef __WXMSW__  // TODO:  should I drop-kick this?
    void DragAcceptFiles(bool accept);
#endif
#endif
    

    // constraints and sizers
    // ----------------------

    // set the constraints for this window or retrieve them (may be NULL)
    void SetConstraints( wxLayoutConstraints *constraints );
    wxLayoutConstraints *GetConstraints() const;

    // when using constraints or sizers, it makes sense to update
    // children positions automatically whenever the window is resized
    // - this is done if autoLayout is on
    void SetAutoLayout( bool autoLayout );
    bool GetAutoLayout() const;

    // lay out the window and its children
    virtual bool Layout();

    // sizers
    void SetSizer(wxSizer *sizer, bool deleteOld = True );
    void SetSizerAndFit( wxSizer *sizer, bool deleteOld = True );

    wxSizer *GetSizer() const;

    // Track if this window is a member of a sizer
    void SetContainingSizer(wxSizer* sizer);
    wxSizer *GetContainingSizer() const;



    // accessibility
    // ----------------------
#if wxUSE_ACCESSIBILITY
    // Override to create a specific accessible object.
    virtual wxAccessible* CreateAccessible();

    // Sets the accessible object.
    void SetAccessible(wxAccessible* accessible) ;

    // Returns the accessible object.
    wxAccessible* GetAccessible() { return m_accessible; };

    // Returns the accessible object, creating if necessary.
    wxAccessible* GetOrCreateAccessible() ;
#endif



    %pythoncode {
    def PostCreate(self, pre):
        """Phase 3 of the 2-phase create <wink!>
           Call this method after precreating the window with the 2-phase create method."""
        self.this = pre.this
        self.thisown = pre.thisown
        pre.thisown = 0
        if hasattr(self, '_setOORInfo'):
            self._setOORInfo(self)
        if hasattr(self, '_setCallbackInfo'):
            self._setCallbackInfo(self, self.__class__)
    }
};








%pythoncode {
def DLG_PNT(win, point_or_x, y=None):
    if y is None:
        return win.ConvertDialogPointToPixels(point_or_x)
    else:
        return win.ConvertDialogPointToPixels(wx.Point(point_or_x, y))

def DLG_SZE(win, size_width, height=None):
    if height is None:
        return win.ConvertDialogSizeToPixels(size_width)
    else:
        return win.ConvertDialogSizeToPixels(wx.Size(size_width, height))
}




// Unfortunatly the names of these new static methods clash with the
// names wxPython has been using forever for the overloaded
// wxWindow::FindWindow, so instead of swigging them as statics create
// standalone functions for them.


// Find a window among any window in the application (all return NULL if not found)
%inline %{
wxWindow* wxFindWindowById( long id, const wxWindow *parent = NULL ) {
    return wxWindow::FindWindowById(id, parent);
}

wxWindow* wxFindWindowByName( const wxString& name,
                              const wxWindow *parent = NULL ) {
     return wxWindow::FindWindowByName(name, parent);
}

wxWindow* wxFindWindowByLabel( const wxString& label,
                               const wxWindow *parent = NULL ) {
    return wxWindow::FindWindowByLabel(label, parent);
}
%}



%inline %{
    wxWindow* wxWindow_FromHWND(unsigned long hWnd) {
#ifdef __WXMSW__
        wxWindow* win = new wxWindow;
        win->SetHWND(hWnd);
        win->SubclassWin(hWnd);
        return win;
#else
        wxPyRaiseNotImplemented();
        return NULL;
#endif
    }
%}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------


  CKEDITOR.editorConfig = function( config )     
    {     
	    config.skin='moono_blue';
        config.toolbar = 'MyToolbar';//把默认工具栏改为‘MyToolbar’     
        
        config.toolbar_MyToolbar =     
        [     
          	['Bold','Italic','Underline','-','Table'],
          	['Font','FontSize'],
          	['TextColor','BGColor'],
        	['Image','Flash','Table'],
         	['Link','Unlink','Anchor'],
          	['Source','Maximize']
        ];
        
        
    };  
    
    

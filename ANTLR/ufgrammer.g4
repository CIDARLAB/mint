/*
 * krishna
 */

grammar ufgrammer;

netlist 
    :   importBlock?
        header 
        ufmoduleBlock?
        flowBlock? 
        controlBlock? 
        behaviorBlock?
        EOF
    ;

importBlock
    :   importStat+
    ;

importStat
    :   'IMPORT' ufmodulename 
    ;

header  
    :   (tag='3D')? 'DEVICE' ufname  
    ;

ufmoduleBlock
    :   (moduleStat)+
    ;
        
moduleStat
    :   ufmoduleStat
    |   terminalBankStat
    ;

ufmoduleStat
    :   ufmodulename ufnames ';'
    ;

flowBlock 	
    :   'LAYER FLOW' 
        (s=flowStat)+ 
        'END LAYER' 
    ;

flowStat 	
    :   portStat
    |   portBankStat
    |   channelStat
    |   nodeStat
    |   cellTrapStat
    |   cellTrapBankStat
    |   logicArrayStat
    |   muxStat
    |   treeStat
    |   setCoordStat
    |   mixerStat
    |   gradGenStat
    |   rotaryStat
    |   dropletGenStat
    |   valve3DStat
    |   viaStat
    |   transposerStat
    |   terminalStat
    |   reactionChamberStat
    |   diamondChamberStat
    |   terminalBankStat
    |   taperStat
    ;

controlBlock
    :   'LAYER CONTROL'
        (s=controlStat)+ 
        'END LAYER'          
    ;

behaviorBlock
    :   'BEHAVIOR'
        protocolBlock+
        'END BEHAVIOR'
    ;

protocolBlock
    :   'PROTOCOL' protocolname
        protocolStat+
        'END PROTOCOL'
    ;

controlStat 
    :   portStat
    |   portBankStat
    |   channelStat
    |   nodeStat
    |   valveStat
    |   setCoordStat
    |   netStat
    |   ufmoduleStat
    |   terminalStat
    |   terminalBankStat
    ;

protocolStat
    :   setProtocolStat
    |   waitProtocolStat
    |   doProtocolStat
    |   startProtocolStat
    ;

//Flow and Control Statements

portStat
    :   'PORT' ufnames (radiusParam)';'
    ;
   
portBankStat
    :   orientation='V' 'BANK' ufname 'of' number=INT 'PORT'  verticalPortBankStatParams ';'
    |   orientation='H' 'BANK' ufname 'of' number=INT 'PORT'  horizontalPortBankStatParams ';'
    ;

verticalPortBankStatParams
    :   (verticalPortBankStatParam)+
    ;

verticalPortBankStatParam
    :   radiusParam
    |   verticalDirectionParam
    |   spacingParam
    |   channelWidthParam 
    ;

horizontalPortBankStatParams
    :   (horizontalPortBankStatParam)+
    ;

horizontalPortBankStatParam
    :   radiusParam
    |   horizontalDirectionParam
    |   spacingParam
    |   channelWidthParam 
    ;

channelStat
    :   'CHANNEL' ufname 'from' component1=ID port1=INT 'to' component2=ID port2=INT widthParam ';'
    ;

nodeStat
    :   'NODE' ufnames ';'
    ;

cellTrapStat
    :   (type='SQUARE CELL TRAP') ufnames cellTrapStatParams ';'
    |   orientation=('V'|'H') (type='LONG CELL TRAP') ufnames  cellTrapStatParams ';'
    ;

cellTrapStatParams
    :   (cellTrapStatParam)+
    ;

cellTrapStatParam
    :   chamberWidthParam
    |   chamberLengthParam
    |   channelWidthParam
    |   numChambersParam
    |   chamberSpacingParam
    |   chamberLengthParam
    ;

cellTrapBankStat
    :   orientation=('V'|'H') 'BANK' ufname 'of' number=INT 'CELL TRAP'  cellTrapBankStatParams';'
    ;

cellTrapBankStatParams
    :   (cellTrapBankStatParam)+
    ;

cellTrapBankStatParam
    :   numChambersParam
    |   chamberWidthParam
    |   chamberLengthParam
    |   chamberSpacingParam
    |   channelWidthParam
    |   spacingParam
    ;


logicArrayStat
    :   'LOGIC ARRAY' ufname logicArrayStatParams ';'
    ;

logicArrayStatParams
    :   (logicArrayStatParam)+
    ;

logicArrayStatParam
    :   flowChannelWidthParam
    |   controlChannelWidthParam
    |   chamberLengthParam
    |   chamberWidthParam 
    |   radiusParam
    ;

muxStat
    :   orientation=('V'|'H') (type='MUX') ufname n1=INT 'to' n2=INT muxStatParams ';'       
    ;

muxStatParams
    :   (muxStatParam)+
    ;

muxStatParam
    :   spacingParam
    |   flowChannelWidthParam
    |   controlChannelWidthParam
    ;

treeStat
    :   orientation=('V'|'H') (type='TREE') ufname n1=INT 'to' n2=INT treeStatParams ';'
    ;

treeStatParams
    :   (treeStatParam)+
    ;

treeStatParam
    :   spacingParam
    |   flowChannelWidthParam
    ;

setCoordStat
    :   ufname setCoordParam+ ';'
    ;

setCoordParam
    :   'SET' coordinate=('X'|'Y') val=INT
    ;

mixerStat
    :   orientation=('V'|'H') 'MIXER' ufname mixerStatParams ';'
    ;

mixerStatParams
    :   (mixerStatParam)+
    ;

mixerStatParam
    :   numBendsParam
    |   bendSpacingParam 
    |   bendLengthParam
    |   channelWidthParam
    ;

gradGenStat
    :   orientation=('V'|'H') 'GRADIENT GENERATOR' ufname in=INT 'to' out=INT gradGenStatParams ';'
    ;


gradGenStatParams
    :   (gradGenStatParam)+
    ;

gradGenStatParam
    :   numBendsParam 
    |   bendSpacingParam
    |   bendLengthParam
    |   channelWidthParam 
    |   focusParam
    ;


rotaryStat
    :   orientation=('V'|'H') 'ROTARY PUMP' ufname rotaryStatParams ';'
    ;


rotaryStatParams
    :   (rotaryStatParam)+
    ;

rotaryStatParam
    :   radiusParam
    |   flowChannelWidthParam 
    |   controlChannelWidthParam
    ;

dropletGenStat
    :   orientation=('V'|'H') 'DROPLET GENERATOR' (type='T') ufname dropletGenStatParams ';' 
    |   orientation=('V'|'H') 'DROPLET GENERATOR' (type='FLOW FOCUS') ufname dropletGenStatParams ';'
    |   orientation=('V'|'H') 'DROPLET GENERATOR' (type='NOZZLE') ufname dropletGenStatParams ';'
    ;

dropletGenStatParams
    :   (dropletGenStatParam)+
    ;

dropletGenStatParam
    :   radiusParam
    |   oilChannelWidthParam
    |   waterChannelWidthParam 
    |   angleParam
    |   lengthParam
    |   orificeWidthParam
    ;


valve3DStat
    :   orientation=('V'|'H') '3DVALVE' ufname valve3DStatParams ';'
    ;

valve3DStatParams
    :   (valve3DStatParam)+
    ;

valve3DStatParam
    :   radiusParam
    |   gapParam
    ;



viaStat
    :   'VIA' ufnames ';'
    ;

transposerStat
    :   'TRANSPOSER' ufname transposerStatParams ';' 
    ;


transposerStatParams
    :   (transposerStatParam)+
    ;

transposerStatParam
    :   radiusParam
    |   gapParam
    |   flowChannelWidthParam
    |   controlChannelWidthParam
    ;


valveStat
    :   'VALVE' ufname 'on' channel=ID widthParam? lengthParam?';'
    ; 

netStat
    :   'NET' ufname 'from' source_name=ID source_terminal=INT 'to' uftargets channelWidthParam ';'
    ;

terminalStat
    :   'TERMINAL' ufname ufterminalnumber positionParamStat? ';'
    ;

terminalBankStat
    :   'TERMINAL BANK' ufname 'from' startpin=INT 'to' endpin=INT terminalBankStatParams ';' 
    ;

terminalBankStatParams
    :   (terminalBankStatParam)+
    ;

terminalBankStatParam
    :   spacingParam
    |   positionParamStat
    ;

taperStat
    :   orientation=('V'|'H') 'TAPER' ufnames taperStatParams ';'
    ;

taperStatParams
    :   (taperStatParam)+
    ;



taperStatParam
    :   maxWidthParam
    |   taperingDegreeParam   
    |   channelLengthParam
    ;

taperBankStat
    :   orientation=('V'|'H') 'BANK' ufname 'of' number=INT 'TAPER'  taperStatParams';'
    ;

//Experimental
reactionChamberStat
    :   'REACTION CHAMBER' ufnames reactionChamberStatParams ';'
    ;

reactionChamberStatParams
    :   (reactionChamberStatParam)+
    ;

reactionChamberStatParam
    :   widthParam
    |   lengthParam
    ;

diamondChamberStat
    :   orientation=('V'|'H') 'DIAMOND CHAMBER' ufnames diamondChamberStatParams ';'
    ;

diamondChamberStatParams
    :   (diamondChamberParam)+
    ;

diamondChamberParam
    :   channelWidthParam
    |   lengthParam
    |   widthParam
    ;


// Behavior Stats

setProtocolStat
    :   ufname 'SET' statevalue=( 'ON' | 'OFF' | INT ) ';'
    ;

waitProtocolStat
    :   'WAIT' timePeriodExpression ';'
    ;

timePeriodExpression
    :   timePeriod+
    ;

timePeriod
    : durationValue=INT unit=( 'H' | 'M' | 'S' )
    ;

doProtocolStat
    :   ufname? 'DO' protocolname ';'
    ;

startProtocolStat
    :   ufname? 'START' protocolname ';'
    ;

//Parameter Stats

focusParam
    :   'focus''='value
    ;

channelLengthParam
    :   'channelLength''='channellength=value
    ;

maxWidthParam
    :   'maxWidth''='maxwidth=value
    ;

taperingDegreeParam
    :   'taperingDegree''='taperingdegree=value
    ;

positionParamStat
    :   'position''=' position=('TOP'|'BOTTOM'|'LEFT'|'RIGHT')
    ;

radiusParam
    :   'r''='radius=value
    |   'radius''=' radius=value
    |   'valveRadius' '=' valve_radius=value
    ;

angleParam
    :   'angle''=' angle=value
    ;

lengthParam
    :   'length''=' length=value
    |   'l' '=' length=value
    ;

verticalDirectionParam
    :   'dir''='dir=('RIGHT'|'LEFT')
    ;

horizontalDirectionParam
    :   'dir''='dir=('UP'|'DOWN')
    ;

numChambersParam
    :   'numChambers''='num_chambers=value
    ;

chamberWidthParam
    :   'chamberWidth''='chamber_width=value
    ;

chamberLengthParam
    :   'chamberLength''='chamber_length=value
    ;

chamberSpacingParam
    :   'chamberSpacing''='chamber_spacing=value
    ;

spacingParam
    :   'spacing''='spacing=value
    ;

channelWidthParam
    :   'channelWidth''='channel_width=value
    ;

widthParam
    :   'w''='width=value
    |   'width' '=' width=value
    ;

flowChannelWidthParam
    :   'flowChannelWidth''=' flow_channel_width=value
    ;

controlChannelWidthParam
    :   'controlChannelWidth''=' control_channel_width=value
    ;

numBendsParam
    :   'numBends''=' number_bends=value
    ;

bendSpacingParam
    :   'bendSpacing''=' bend_spacing=value
    ;

bendLengthParam
    :   'bendLength''=' bend_length=value
    ;

oilChannelWidthParam
    :   'oilChannelWidth''=' oil_channel_width=value
    ;

waterChannelWidthParam
    :   'waterChannelWidth''=' water_channel_width=value
    ;

gapParam
    :   'gap''=' gap=value
    |   'valveGap''=' valve_gap=value
    ;

orificeWidthParam
    :   'orificeWidth''=' orifice_width=value
    ;

//Common Parser Rules



ufmodulename
    :   ID
    ;

ufterminalnumber
    :   INT
    ;

uftargets
    :    uftarget (',' uftarget)+
    ;

uftarget
    :   target_name=ID target_terminal=INT
    ;

ufname
    :   ID
    ;

ufnames
    :   ufname (',' ufname)*
    ;
        
value
    :   (INT | BOOLEAN)
    ;

protocolname
    :   ID
    ;

//Common Lexical Rules

BOOLEAN :   ('YES'|'NO');

ID  :	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
    ;

INT :   [0-9]+ ; // Define token INT as one or more digits
WS  :   [ \t\r\n]+ -> skip ; // Define whitespace rule, toss it out

COMMENT :    '#' ~[\r\n]* -> skip ;
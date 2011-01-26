#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>

CHDeclareClass(SBAccelerometerInterface);
CHDeclareClass(SBCallAlertDisplay);

static SBCallAlertDisplay *callAlert;

CHMethod(5, void, SBAccelerometerInterface, accelerometerDataReceived,double,received,x,float,x,y,float,y,z,float,z,type,unsigned,type)
{
if((x>0.3 || z> 0.1 || y>.1) && callAlert)
{
	[callAlert stopRingingOrVibrating];
	}
CHSuper(5, SBAccelerometerInterface, accelerometerDataReceived,received,x,x,y,y,z,z,type,type);
}

CHMethod(0, void, SBCallAlertDisplay, finishedAnimatingIn)
{
	if(!callAlert)
	{
	callAlert = [self retain];
	CHLoadLateClass(SBAccelerometerInterface);
	CHHook(5, SBAccelerometerInterface, accelerometerDataReceived,x,y,z,type);
	}
	
	CHSuper(0, SBCallAlertDisplay, finishedAnimatingIn);
}

CHMethod(0, void, SBCallAlertDisplay, answerAndRelease)
{	
	CHSuper(0, SBCallAlertDisplay, answerAndRelease);
}

CHMethod(0, void, SBCallAlertDisplay, ignoreAndRelease)
{	
	CHSuper(0, SBCallAlertDisplay, ignoreAndRelease);
}

CHConstructor
{	
	CHLoadLateClass(SBCallAlertDisplay);
	CHHook(0, SBCallAlertDisplay, finishedAnimatingIn);
	CHHook(0, SBCallAlertDisplay, answerAndRelease);
	CHHook(0, SBCallAlertDisplay, ignoreAndRelease);
	
}


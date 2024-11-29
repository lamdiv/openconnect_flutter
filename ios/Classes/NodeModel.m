
#import "NodeModel.h"
#import "CheckConnectData.h"

@implementation NodeModel
static NodeModel * modal = nil;

+(instancetype)shareInstance {
    @synchronized (self) {
        if(!modal) {
            modal = [[self alloc] init];
            modal.selectNode = [NodeModel new];
        }
        return modal;
    }
}

@end

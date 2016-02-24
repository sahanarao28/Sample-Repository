//
//  ViewController.m
//  ExamplePods
//

#import "ViewController.h"
#import "RNDecryptor.h"
#import "RNEncryptor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Encryption
    NSString *string = @"Plain Text";
    NSData *data = [string dataUsingEncoding:NSUTF16StringEncoding];
    NSString *key = @"Secret Key";
    NSData *ciphertext = [self encryptData:data withKey:key];
    
    // Decryption
    NSData *plaintext = [self decryptData:ciphertext withKey:key];
    NSString *decryptedText = [[NSString alloc]initWithData:plaintext encoding:NSUTF16StringEncoding];
    NSLog(@"%@",decryptedText);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSData *)encryptData:(NSData*)plainData withKey:(NSString *)key
{
    NSError *error;
    NSData *data = [RNEncryptor encryptData:plainData withSettings:kRNCryptorAES256Settings password:key error:&error];
    if (error!=nil) {
        NSLog(@"Failed to encrypt");
        return nil;
    }
    else
    {
        return data;
    }
}

-(NSData *)decryptData:(NSData *)cipherData withKey:(NSString*)key
{
    NSError *error;
    NSData *data = [RNDecryptor decryptData:cipherData withPassword:key error:&error];
    if (error!=nil) {
        NSLog(@"Failed to decrypt");
        return nil;
    }
    else
    {
        return data;
    }

}
@end

//
//  RNNumberSpellingViewController.m
//  SlidingViewController
//
//  Created by Roberto Neira on 2015-08-16.
//  Copyright (c) 2015 Roberto Neira. All rights reserved.
//

#import "RNNumberSpellingViewController.h"
#import <AVFoundation/AVFoundation.h>


/**
 Borrowed from https://gist.github.com/mattt/9892187
 */
static NSString * BCP47LanguageCodeFromISO681LanguageCode(NSString *ISO681LanguageCode) {
	if ([ISO681LanguageCode isEqualToString:@"ar"]) {
		return @"ar-SA";
	} else if ([ISO681LanguageCode hasPrefix:@"cs"]) {
		return @"cs-CZ";
	} else if ([ISO681LanguageCode hasPrefix:@"da"]) {
		return @"da-DK";
	} else if ([ISO681LanguageCode hasPrefix:@"de"]) {
		return @"de-DE";
	} else if ([ISO681LanguageCode hasPrefix:@"el"]) {
		return @"el-GR";
	} else if ([ISO681LanguageCode hasPrefix:@"en"]) {
		return @"en-US"; // en-US, en-AU, en-GB, en-IE, en-ZA
	} else if ([ISO681LanguageCode hasPrefix:@"es"]) {
		return @"es-ES"; // es-ES, es-MX
	} else if ([ISO681LanguageCode hasPrefix:@"fi"]) {
		return @"fi-FI";
	} else if ([ISO681LanguageCode hasPrefix:@"fr"]) {
		return @"fr-CA"; // fr-FR, fr-CA
	} else if ([ISO681LanguageCode hasPrefix:@"hi"]) {
		return @"hi-IN";
	} else if ([ISO681LanguageCode hasPrefix:@"hu"]) {
		return @"hu-HU";
	} else if ([ISO681LanguageCode hasPrefix:@"id"]) {
		return @"id-ID";
	} else if ([ISO681LanguageCode hasPrefix:@"it"]) {
		return @"it-IT";
	} else if ([ISO681LanguageCode hasPrefix:@"ja"]) {
		return @"ja-JP";
	} else if ([ISO681LanguageCode hasPrefix:@"ko"]) {
		return @"ko-KR";
	} else if ([ISO681LanguageCode hasPrefix:@"nl"]) {
		return @"nl-NL"; // nl-NL, nl-BE
	} else if ([ISO681LanguageCode hasPrefix:@"no"]) {
		return @"no-NO";
	} else if ([ISO681LanguageCode hasPrefix:@"pl"]) {
		return @"pl-PL";
	} else if ([ISO681LanguageCode hasPrefix:@"pt"]) {
		return @"pt-BR"; // pt-BR, pt-PT
	} else if ([ISO681LanguageCode hasPrefix:@"ro"]) {
		return @"ro-RO";
	} else if ([ISO681LanguageCode hasPrefix:@"ru"]) {
		return @"ru-RU";
	} else if ([ISO681LanguageCode hasPrefix:@"sk"]) {
		return @"sk-SK";
	} else if ([ISO681LanguageCode hasPrefix:@"sv"]) {
		return @"sv-SE";
	} else if ([ISO681LanguageCode hasPrefix:@"th"]) {
		return @"th-TH";
	} else if ([ISO681LanguageCode hasPrefix:@"tr"]) {
		return @"tr-TR";
	} else if ([ISO681LanguageCode hasPrefix:@"zh"]) {
		return @"zh-CN"; // zh-CN, zh-HK, zh-TW
	} else {
		return nil;
	}
}




@interface RNNumberSpellingViewController ()

@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;

@property (nonatomic, strong) IBOutlet UILabel *numberLabel;

@property (nonatomic, strong) IBOutlet UILabel *currentLanguage;
@property (nonatomic, strong) IBOutlet UILabel *numberInCurrentLanguage;
@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *currentLanguageGestureRecognizer;

@property (nonatomic, strong) IBOutlet UILabel *otherLanguage;
@property (nonatomic, strong) IBOutlet UILabel *numberInOtherLanguage;
@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *otherLanguageGestureRecognizer;

@end


@implementation RNNumberSpellingViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.synthesizer = [[AVSpeechSynthesizer alloc] init];
}



#pragma mark -
#pragma mark Custom getters and setters

- (void)setNumber:(NSNumber *)number {
	if (![_number isEqualToNumber:number]) {
		_number = number;
		
		[self _refreshUI];
	}
}


- (void)setLocale:(NSLocale *)locale {
	if (![_locale isEqual:locale]) {
		_locale = locale;
		
		[self _refreshUI];
	}
}



#pragma mark -
#pragma mark Private methods

- (void)_refreshUI {
	NSLocale *currentLocale = [NSLocale currentLocale];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle: NSNumberFormatterSpellOutStyle];
	[formatter setLocale:currentLocale];
	
	self.numberLabel.text = self.number.stringValue;
	self.currentLanguage.text = [currentLocale displayNameForKey:NSLocaleIdentifier value:currentLocale.localeIdentifier];
	self.otherLanguage.text = [currentLocale displayNameForKey:NSLocaleIdentifier value:self.locale.localeIdentifier];
	self.numberInCurrentLanguage.text = [formatter stringFromNumber:self.number];
	
	formatter.locale = self.locale;
	self.numberInOtherLanguage.text = [formatter stringFromNumber:self.number];
}


- (IBAction)_sayNumberInCurrentLanguage:(id)sender {
	NSString *string = self.numberInCurrentLanguage.text;
	NSString *synthesizerLanguageCode = BCP47LanguageCodeFromISO681LanguageCode([NSLocale currentLocale].localeIdentifier);
	
	AVSpeechUtterance *utterance = [self _utteranceWithString:string BCP47LanguageCode:synthesizerLanguageCode];
	
	[self.synthesizer speakUtterance:utterance];
}


- (IBAction)_sayNumberInOtherLanguage:(id)sender {
	NSString *string = self.numberInOtherLanguage.text;
	NSString *synthesizerLanguageCode = BCP47LanguageCodeFromISO681LanguageCode(self.locale.localeIdentifier);
	
	AVSpeechUtterance *utterance = [self _utteranceWithString:string BCP47LanguageCode:synthesizerLanguageCode];
	
	[self.synthesizer speakUtterance:utterance];
}


- (AVSpeechUtterance *)_utteranceWithString:(NSString *)string BCP47LanguageCode:(NSString *)languageCode {
	AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:string];
	utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:languageCode];
	utterance.rate = AVSpeechUtteranceDefaultSpeechRate;
	utterance.preUtteranceDelay = 0.100;
	
	return utterance;
}

@end

//
//  main.m
//  BeautifulStrings


#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString  *line = @"aBbCcc";
        
        line = [line lowercaseString];
        
        NSInteger highestSum = 0;
        
        NSCharacterSet *lowercaseLettersSet = [NSCharacterSet lowercaseLetterCharacterSet];
        
        NSMutableDictionary *lettersAndCountdMutDict = [[NSMutableDictionary alloc]init];
        
        NSInteger i = 0;
        for (i = 0; i < line.length; i++) {
            char charAtIndex = [line characterAtIndex:i];
            
            if ([lowercaseLettersSet characterIsMember:charAtIndex]) {
                NSString *letterKey = [NSString stringWithFormat:@"%c", charAtIndex];
                
                if (![[lettersAndCountdMutDict allKeys] containsObject:letterKey]) {
                    [lettersAndCountdMutDict setValue:[NSNumber numberWithInteger:1] forKey:letterKey];
                }
                else {
                    NSInteger valueInt = [[lettersAndCountdMutDict valueForKey:letterKey] integerValue] + 1;
                    [lettersAndCountdMutDict setValue:[NSNumber numberWithInteger:valueInt] forKey:letterKey];
                }
            }
        }
        
        // builds array of counts
        NSMutableArray *countsMutArray = [[NSMutableArray alloc]initWithArray:[lettersAndCountdMutDict allValues]];
        
//        for (NSNumber *countValue in [lettersAndCountdMutDict allValues]) {
//            [countsMutArray addObject:countValue];
//        }
        
//        //sort array of counts NSSSortDescriptor Not allowed
//        NSSortDescriptor *highToLowSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
//        [countsMutArray sortUsingDescriptors:[NSArray arrayWithObject:highToLowSortDescriptor]];

        // build descending sort loop
        BOOL countsMutArraySorted = NO;
        
        while (!countsMutArraySorted) {
            countsMutArraySorted = YES;
            
            NSInteger k = 0;
            for (k = 0; k < countsMutArray.count - 1; k ++) {
                NSNumber *numAtK = [countsMutArray objectAtIndex:k];
                NSNumber *numAtKPlusOne = [countsMutArray objectAtIndex:k + 1];
                
                // codeEval didn't like me comparing nsnumbers directly :(
                if ([numAtK integerValue] < [numAtKPlusOne integerValue]) {
                    [countsMutArray removeObjectAtIndex:k + 1];
                    [countsMutArray insertObject:numAtKPlusOne atIndex:k];
                    countsMutArraySorted = NO;
                }
            }
        }
    
        NSLog(@"countsMutArray: %@", countsMutArray);
        
        
        NSInteger j = 0;
        for (j = 0; j < countsMutArray.count; j ++) {
            NSInteger countAtIndexJ = [[countsMutArray objectAtIndex:j] integerValue];
            highestSum = highestSum + (countAtIndexJ * (26 - j));
        }
        
        
        NSLog(@"%@", countsMutArray);
        NSLog(@"%ld", highestSum);
    
    }
    
    return 0;
}

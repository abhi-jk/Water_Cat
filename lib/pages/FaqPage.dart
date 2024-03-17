import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frequently Asked Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildFaq(
                context,
                'Why soap is not lathering?',
                'This is due to the property of excessive hardness present in water. Hardness is mainly contributed by calcium and magnesium ions.',
              ),
              _buildFaq(
                context,
                'Why water is becomes turbid and brownish yellow colour?',
                'Usually, certain underground water may have ferrous iron dissolved in it. When this water comes into contact with the air, the ferrous iron reacts and changes into a solid substance called ferric iron hydroxide. This solid substance appears as a brownish-yellow precipitate.',
              ),
              _buildFaq(
                context,
                'Why boiled rice is hard and yellow in colour?',
                'This is due to the property of high alkalinity in water. Alkalinity is mainly contributed by bicarbonate.',
              ),
              _buildFaq(
                context,
                'What is the reason for algae growth?',
                'Trace level of phosphorous and nitrogen aid for algae growth. If the accumulation of nutrient increases it will lead to eutrophication.',
              ),
              _buildFaq(
                context,
                'How white deposits in vessels (when water is stored/boiled)?',
                'The scales are due to precipitation of calcium carbonate from water. Scale formation is notable when the water is temporary hardness. The water after filtration can be used without any harm.',
              ),
              _buildFaq(
                context,
                'What is the reason for oily suspensions noted on the surface of water in wells?',
                'This is also due to precipitation of calcium carbonate in water.',
              ),
              _buildFaq(
                context,
                'How white deposits blocking the PVC pipes?',
                'This is due to deposition of calcium carbonate scales. This is found particularly when compressor pumps are used.',
              ),
              // Add the rest of your FAQs here...
              _buildFaq(context, 'Why rotten egg smell occurs in water? ',
                  'In the absence of sufficient air and under anaerobic conditions, hydrogen sulfide is formed due to putrefaction of organic matter in water. This causes rotton egg smell in water. '),
              _buildFaq(
                  context,
                  'Why brownish or brownish-black slimes formed in water conveying pipes? ',
                  'May be due to growth of iron bacteria in water. '),
              _buildFaq(
                  context,
                  'How clothes loose their shining and become dirty after some washings ?  ',
                  'This is due to presence of high hardness and iron in water used for washing. Good lathering can occur with detergents but the cleaning action in hard water will not be always satisfactory. '),
              _buildFaq(
                  context,
                  'Explain reason for formation of slime in closet in toilets and in the floors of bathroom ?  ',
                  'This happens due to microbial causing micro-organisms (called pathogens) in water.  '),
              _buildFaq(
                  context,
                  'Whether the presence of septic tank may affect the quality of water in nearby wells?  ',
                  'If the seepage from septic tank mixes with well water, it can definitely affect the quality of water and can cause water borne disease. Mixing of septic tank waste or sewage in drinking water can be easily identified by test in for ammonia, phosphate and fecal coliform. There should be sufficient distance (at least 7.5m) between the septic tank and a well. '),
              _buildFaq(context, 'How to do chlorination in open well?',
                  "To chlorinate an open well, follow these simple steps. First, calculate the required amount of chlorine based on the well's volume and the desired concentration. As a general guideline, for every 1000 liters (or 1000 ml) of water in the well, you can use approximately 2.5 grams of chlorine in the form of bleaching powder for normal chlorination and 5 grams for super chlorination. Adjust the quantity accordingly based on your specific well volume. Prepare the chlorine solution using the recommended amount of bleaching powder and water allow the mixture to settle. Lower the clear solution into the well, mix it thoroughly, and let it sit for 24-48 hours. Flush the well afterwards and test the water quality for safety. Seek guidance from a professional or local health authority if needed. "),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaq(BuildContext context, question, String answer) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style.copyWith(
            fontSize: 16, height: 1.5, decoration: TextDecoration.none),
        children: <TextSpan>[
          TextSpan(
            text: question + '\n',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue),
          ),
          TextSpan(
            text: answer + '\n\n',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

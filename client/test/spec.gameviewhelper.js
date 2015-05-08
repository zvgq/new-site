
describe('GameViewHelper', function() {
	'use strict';

	describe('#init()', function() {

		/*
		**	SPEC
		*/
		it('should show a quote if the quoteId is part of the URL', function() {
			var spyShowQuote
				, stubCheckQueryString;

			// GIVEN
			spyShowQuote = sinon.spy(GameViewHelper, 'showQuote');
			stubCheckQueryString = sinon.stub(GameViewHelper, 'checkQueryString').returns(true);
			// WHEN
			GameViewHelper.init();
			// THEN
			expect(spyShowQuote.calledOnce).to.be.true;
			expect(stubCheckQueryString.calledOnce).to.be.true;
		});

	}); // #init
});

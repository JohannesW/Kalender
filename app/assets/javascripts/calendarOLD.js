

//we need to provide an html div container, maybe with min-width/height attribute and id="calendar" to be pimped by jquery

var calendar = $("#calendar");



function renderCalendar() {
	
	calendar.fullCalendar({

		viewDisplay : function(view) {

			renderItems();
			
		},
		eventSources : [ {

		// These lines enable us to define numerous sources, like "outgoing" urls/links to our own say "ajaxjsoncontroller" or whatsoever, to scrape JSON from
		// could either be a call to a controller of ourselves a là ourdomain/ourcontroller/ouraction?format=json&start=142105201501&end=151250101225 
		// with the userid implicitely known via session scope or we maybe let a user supply a link to his google calendar and include these too, which works just as nice 	
		



					
			events : function(start, end, callback) {

				fetchEventsSourceA(start, end, callback) 
			},
			className : 'eventItem'

		}

		//, {
		//	events : function(start, end, callback) {
		//		fetchEventsSourceB(start, end, callback);
		//	}
		//,
		//	color : 'yellow', // an option!
		//	textColor : 'black', // an option!
		//	backgroundColor : 'red',
		//	className : 'eventItem'

		}

		],

		header : {
			left : 'prev,next today',
			center : 'title',
			right : 'month,agendaWeek,agendaDay'
		},

		aspectRatio : .75,

		eventAfterRender : function(event, element) {
			
			//...		
			
		},

		eventRender : function(event, element) {
			
			//...
		},

		eventClick : function(event, jsEvent, view) {

			alert('event: \'' + event.id + '\'');

			//...

		}

		
	});
}


//just as an example function

functionfetchEventsSourceA(start, end, callback) 
{

					
				$.ajax({
				
				
				url : 'ourwebapp/ourcontroller/listEventsPeriod?format=json',
				
				
				data : {
					start : Math.round(start.getTime() / 1000),
					end : Math.round(end.getTime() / 1000),
					
					
				// probably tell the controller somehow who we are, I figured that if we gonna implement authentication process using a ruby gem, we gonna haVe
				// some app-scoped access to the currently logged in user, so maybe we dont event need this unless we are (authorized and) looking at someone elses calendar
				// and need to know whos events to render...


					owner: '${user.username}'
					
					
				},
				dataType : 'json',
				success : function(data) {
					if (!data) {
						alert('problem while getting calendar events');
						return;
					}
						
					eventsCallBack(data);

				}
				});	
				

}
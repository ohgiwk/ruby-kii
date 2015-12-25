class KiiHttpClientObserver

    def initialeze(fp)
        @fp = fp
    end

    def update(subject)
        event = subject.getLastEvent()

        case event['name']
        when 'receivedBodyPart'
        when 'receivedEncodedBodyPart'
            fwrite(@fp, event['data'])

        when 'receivedBody'
        	# nop
        end
    end
end

#define ON  1
#define OFF 0

enum { UP, DOWN, NONE } direction;
enum { OPEN, CLOSED } door;

loop() {
    while (!ECOMP);        // wait for current action to complete

    // Clear all outputs
    EMVUP = OFF;
    EMVDN = OFF;
    EOPEN = OFF;
    ECLOSE = OFF;

    if (door == OPEN) {
        ECLOSE = ON;
        door = CLOSED;
    } else if (EF & GO_REQ) {
        EOPEN = ON;
        door = OPEN;
    } else {
        // Masks for floors above and below current floor
        unsigned bcmask = EF - 1;
        unsigned acmask = ~(bcmask | EF);

        // Checks for at least one request at any floor
        unsigned all_req = UP_REQ | DN_REQ | GO_REQ;

        int req_above = (all_req & acmask) > 0;
        int req_below = (all_req & bcmask) > 0;

        switch (direction) {
        case UP:
            // Check for requests in direction of travel
            if (EF & UP_REQ) {
                EOPEN = ON;
                door = OPEN;
            } else {
                // Prioritize requests in direction of travel
                if (req_above) {
                    EMVUP = ON;
                } else if (req_below) {
                    EMVDN = ON;
                    direction = DOWN;
                } else {
                    direction = NONE;
                }
            }
        case DOWN:
            // Check for requests in direction of travel
            if (EF & DN_REQ) {
                EOPEN = ON;
                door = OPEN;
            } else {
                // Prioritize requests in direction of travel
                if (req_below) {
                    EMVDN = ON;
                } else if (req_above) {
                    EMVUP = ON;
                    direction = UP;
                } else {
                    direction = NONE;
                }
            }
        default:
            // Prefer starting upward
            if (req_above) {
                EMVUP = ON;
                direction = UP;
            } else if (req_below) {
                EMVDN = ON;
                direction = DOWN;
            }
        }
    }
}

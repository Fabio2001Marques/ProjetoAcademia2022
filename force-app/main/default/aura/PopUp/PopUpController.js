({
    apexcall : function(component, event, helper) {
        var hideModal = component.get('v.showModal');
        component.set('v.showModal', !hideModal);
       //logic to do something
    },
    openConfirmDialog : function(component, event, helper) {
        var showModal = component.get('v.showModal');
        component.set('v.showModal', !showModal);
    },
    closeModal : function(component, event, helper) {
        var showModal = component.get('v.showModal');
        component.set('v.showModal', !showModal);
    },
})
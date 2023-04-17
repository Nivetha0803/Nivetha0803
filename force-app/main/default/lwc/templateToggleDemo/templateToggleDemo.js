import { LightningElement,track} from 'lwc';

export default class TemplateToggleDemo extends LightningElement {
    @track toggleText=false;

    toggleHandler()
    {
        this.toggleText=!this.toggleText;
    }
}